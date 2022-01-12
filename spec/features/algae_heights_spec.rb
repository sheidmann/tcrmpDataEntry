require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing algae heights index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of algae heights" do
    visit('/algae_heights')
    expect(page).to have_content "Algae Heights"
    puts 'user can see algae heights'
  end
  it "can create an algae height transect" do
    visit('/algae_heights')
    click_button("New Algae Heights Transect")
    expect(page).to have_content "New Algae Height Transect"
    puts 'user can create a new algae heights transect'
  end
end