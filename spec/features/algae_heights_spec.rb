require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing algae heights index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    @algae = create(:algae)
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of algae heights" do
    @aht = create(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/algae_heights')
    expect(page).to have_content "My Site"
    expect(page).to have_css('tr')
    puts 'user can see algae heights with option to view'
  end
  it "can create an algae height transect" do
    visit('/algae_heights')
    click_button("New Algae Heights Transect")
    expect(page).to have_content "Site Name"

    @aht = build(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    select @blmanager.project, :from => "Project"
    select @aht.site.site_name, :from => "Site Name"
    select @aht.user.name, :from => "Observer"
    fill_in "Date Completed", with: @aht.date_completed.strftime("%Y-%m-%d")
    fill_in "Replicate", with: @aht.rep
    
    @trana = build(:transect_algae, algae_id: @algae.id)
    select @trana.algae.combo_name
    fill_in "heightField", with: @trana.height_cm

    click_button("Save Algae Heights")
    expect(page).to have_content "Algae heights successfully created"
    puts 'user can create a new algae heights transect'
  end
  it "can view an algae heights" do
    @aht = create(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    @trana = create(:transect_algae, algae_height_id: @aht.id, algae_id: @algae.id)
    # I can't make Capybara click on the table row, so we just have to visit the link
    visit("#{algae_height_path(@aht.id)}")
    expect(page).to have_content "My Site"
    expect(page).to have_content "wavy plant stuff"
    puts 'user can view algae height'
  end
  it "can edit an algae heights" do
    @aht = create(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/algae_heights')

    visit("#{algae_height_path(@aht.id)}")
    click_button('Edit Algae Heights')
    expect(page).to have_content "Edit Algae Heights"

    click_button("Save Algae Heights")
    expect(page).to have_content "Algae heights successfully updated"
    puts 'user can edit algae heights'
  end
  it "can delete an algae heights" do
    @aht = create(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit("#{algae_height_path(@aht.id)}")
    accept_confirm do
      click_button('Delete Algae Heights')
    end
    expect(page).to have_content "Algae heights deleted"
    puts 'user can delete algae heights'
    end
end