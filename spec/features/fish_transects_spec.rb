require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "User viewing fish transect index", :js => true, type: :feature do
  before(:each) do
    @manager = create(:manager) # create a user (who is a manager)
    @blmanager = create(:boatlog_manager, user_id: @manager.id) # create a manager
    @site = create(:site, site_name: "My Site")
    @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @fish1 = create(:fish)
      @tranf1 = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish1.id)
      @fish2 = create(:fish)
      @tranf2 = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish2.id)
      @diadema1 = create(:diadema, fish_transect_id: @ftran.id)
      @diadema2 = create(:diadema, fish_transect_id: @ftran.id)
      @diadema3 = create(:diadema, fish_transect_id: @ftran.id)
    visit('/login')
    sign_in(@manager)
  end
  it "sees index of fish transects" do
    visit('/fish_transects')
    expect(page).to have_content "My Site"
    #expect(page).to have_css('tr')
    puts 'user can view boatlogs with option to view'
  end
  it "can view a fish transect" do
      # I can't make Capybara click on the table row, so we just have to visit the link
      visit("#{fish_transect_path(@ftran.id)}")
      expect(page).to have_content "My Site"
      expect(page).to have_content "the coolest fish"
      puts 'user can view fish transect'
  end
  it "can delete a fish transect" do
      visit("#{fish_transect_path(@ftran.id)}")
      accept_confirm do
        click_button('Delete Fish Transect')
      end
      expect(page).to have_content "Fish transect deleted"
      puts 'user can delete fish transect'
    end
end