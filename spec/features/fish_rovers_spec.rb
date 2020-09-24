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
end