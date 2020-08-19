require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing fish transect index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of fish transects" do
    @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
    visit('/fish_transects')
    expect(page).to have_content "My Site"
    #expect(page).to have_css('tr')
    puts 'user can view boatlogs with option to view'
  end
end