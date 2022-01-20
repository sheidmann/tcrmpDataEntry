require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing coral health index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    @coral = create(:coral)
    @int = create(:interaction)
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of coral healths" do
    @ch = create(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/coral_healths')
    expect(page).to have_content "My Site"
    expect(page).to have_css('tr')
    puts 'user can see coral healths with option to view'
  end
  it "can create a coral health transect" do
    visit('/coral_healths')
    click_button("New Coral Health Transect")
    expect(page).to have_content "Site Name"

    @chealth = build(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    select @blmanager.project, :from => "Project"
    select @chealth.site.site_name, :from => "Site Name"
    select @chealth.user.name, :from => "Observer"
    fill_in "Date Completed", with: @chealth.date_completed.strftime("%Y-%m-%d")
    fill_in "Replicate", with: @chealth.rep
    
    @tranc = build(:transect_coral, coral_code_id: @coral.id)
    @corint = build(:coral_interaction)
    select @tranc.coral_code.combo_name
    fill_in "lengthField", with: @tranc.length_cm
    fill_in "widthField", with: @tranc.width_cm
    fill_in "heightField", with: @tranc.height_cm
    fill_in "oldMField", with: @tranc.old_mortality
    fill_in "newMField", with: @tranc.new_mortality

    select @int.combo_name
    fill_in "coral_health_transect_corals_attributes_0_coral_interactions_attributes_0_value", with: @corint.value

    click_button("Save Coral Health")
    expect(page).to have_content "Coral health successfully created"
    puts 'user can create a new coral health transect'
  end
  it "can view a coral health" do
    @chealth = create(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    @tranc = create(:transect_coral, coral_health_id: @chealth.id, coral_code_id: @coral.id)
    # I can't make Capybara click on the table row, so we just have to visit the link
    visit("#{coral_health_path(@chealth.id)}")
    expect(page).to have_content "My Site"
    expect(page).to have_content "Coolus coralus"
    puts 'user can view coral health'
  end
  it "can edit a coral health transect" do
    @chealth = create(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/coral_healths')

    visit("#{coral_health_path(@chealth.id)}")
    click_button('Edit Coral Health')
    expect(page).to have_content "Edit Coral Health"

    click_button("Save Coral Health")
    expect(page).to have_content "Coral health successfully updated"
    puts 'user can edit coral health'
  end
  it "can delete a coral health" do
    @chealth = create(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit("#{coral_health_path(@chealth.id)}")
    accept_confirm do
      click_button('Delete Coral Health')
    end
    expect(page).to have_content "Coral health deleted"
    puts 'user can delete coral health'
    end
end