require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing fish rover index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    @fish = create(:fish)
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of fish rovers" do
    @ftran = create(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/fish_rovers')
    expect(page).to have_content "My Site"
    expect(page).to have_css('tr')
    puts 'user can see fish rovers with option to view'
  end
  it "can create a fish rover" do
    visit('/fish_rovers')
    click_button("New Fish Rover")
    expect(page).to have_content "Site Name"

    @frove = build(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    select @blmanager.project, :from => "Project"
    select @frove.site.site_name, :from => "Site Name"
    select @frove.user.name, :from => "Observer"
    fill_in "Date Completed", with: @frove.date_completed.strftime("%Y-%m-%d")
    fill_in "Begin Time", with: @frove.begin_time.strftime("%H:%M")
    select @frove.oc_cc, :from => "OC/CC"
    fill_in "Replicate", with: @frove.rep

    @rovef = build(:rover_fish, fish_id: @fish.id)
    select @rovef.fish.spp_code_common#, :from => "Species"
    fill_in("fish_rover_rover_fishes_attributes_0_abundance_index", with: @rovef.abundance_index)

    click_button("Save Fish Rover")
    expect(page).to have_content "Fish rover successfully created"
    puts 'user can create a new fish rover'
  end
  it "can view a fish rover" do
    @frove = create(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    @rovef = create(:rover_fish, fish_rover_id: @frove.id, fish_id: @fish.id)
    # I can't make Capybara click on the table row, so we just have to visit the link
    visit("#{fish_rover_path(@frove.id)}")
    expect(page).to have_content "My Site"
    expect(page).to have_content "the coolest fish"
    puts 'user can view fish rover'
  end
end