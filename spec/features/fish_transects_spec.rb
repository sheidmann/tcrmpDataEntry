require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing fish transect index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    @fish = create(:fish)
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of fish transects" do
    @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/fish_transects')
    expect(page).to have_content "My Site"
    expect(page).to have_css('tr')
    puts 'user can see fish transects with option to view'
  end
  it "can create a fish transect" do
    visit('/fish_transects')
    click_button("New Fish Transect")
    expect(page).to have_content "Site Name"

    @ftran = build(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    select @blmanager.project, :from => "Project"
    select @ftran.site.site_name, :from => "Site Name"
    select @ftran.user.name, :from => "Observer"
    fill_in "Date Completed", with: @ftran.date_completed.strftime("%Y-%m-%d")
    # fill_in "Begin Time", with: @ftran.begin_time.strftime("%H:%M")
    select @ftran.oc_cc, :from => "OC/CC"
    fill_in "Replicate", with: @ftran.rep
    fill_in "Meters Completed", with: @ftran.completed_m
    
    @diadema = build(:diadema)
    fill_in "Test Size (cm)", with: @diadema.test_size_cm

    @tranf = build(:transect_fish, fish_id: @fish.id)
    select @tranf.fish.spp_code_common#, :from => "Species"
    fill_in("fish_transect_transect_fishes_attributes_0_x0to5", with: @tranf.x0to5)
    fill_in("fish_transect_transect_fishes_attributes_0_x6to10", with: @tranf.x6to10)
    fill_in("fish_transect_transect_fishes_attributes_0_x11to20", with: @tranf.x11to20)
    fill_in("fish_transect_transect_fishes_attributes_0_x21to30", with: @tranf.x21to30)
    fill_in("fish_transect_transect_fishes_attributes_0_x31to40", with: @tranf.x31to40)
    fill_in("fish_transect_transect_fishes_attributes_0_x41to50", with: @tranf.x41to50)

    click_button("Save Fish Transect")
    expect(page).to have_content "Fish transect successfully created"
    puts 'user can create a new fish transect'
  end
  it "can view a fish transect" do
    @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    @tranf = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish.id)
    # I can't make Capybara click on the table row, so we just have to visit the link
    visit("#{fish_transect_path(@ftran.id)}")
    expect(page).to have_content "My Site"
    expect(page).to have_content "the coolest fish"
    puts 'user can view fish transect'
  end
  it "can edit a fish transect" do
    @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/fish_transects')

    visit("#{fish_transect_path(@ftran.id)}")
    click_button('Edit Fish Transect')
    expect(page).to have_content "Edit Fish Transect"

    click_button("Save Fish Transect")
    expect(page).to have_content "Fish transect successfully updated"
    puts 'user can edit fish transect'
  end
  it "can delete a fish transect" do
    @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit("#{fish_transect_path(@ftran.id)}")
    accept_confirm do
      click_button('Delete Fish Transect')
    end
    expect(page).to have_content "Fish transect deleted"
    puts 'user can delete fish transect'
    end
end