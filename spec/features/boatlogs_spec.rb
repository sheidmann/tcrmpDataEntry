require 'rails_helper'
require 'spec_helper'

Capybara.current_driver = :selenium

describe "Manager viewing boatlog index", :js => true, type: :feature do
    before do
	    @manager = create(:manager)
	    visit('/login')
	    sign_in(@manager)
    end
    it "sees array of boatlogs" do
      @boatlog = create(:boatlog, site: "My Site")
      visit('/boatlogs')
      expect(page).to have_content "My Site"
      expect(page).to have_link("edit", href: edit_boatlog_path(@boatlog.id))
      puts 'manager can view boatlogs with option to edit'
    end
    it "can create a boatlog" do
      @manager = create(:boatlog_manager)
      visit('/boatlogs')
      click_button("New Boatlog")
      expect(page).to have_content "Site Name"

      @boatlog = build(:boatlog)
      fill_in "Site Name", with: @boatlog.site
      fill_in "Date Completed", with: @boatlog.date_completed
      fill_in "Begin Time", with: @boatlog.begin_time.strftime("%H:%M")
      select @boatlog.manager_name, :from => "Manager"
      click_button("New Boatlog")
      expect(page).to have_content "Boatlog successfully created"
      puts 'manager can create a new boatlog'
    end
    it "can edit a boatlog" do
      @boatlog = create(:boatlog)
      visit('/boatlogs')

      click_link('edit')
      expect(page).to have_content "Edit Boatlog"

      click_button("Update Boatlog")
      expect(page).to have_content "Boatlog successfully updated"
      puts 'manager can edit boatlog'
    end
    it "can delete a boatlog" do
      @boatlog = create(:boatlog)
      visit('/boatlogs')
      accept_confirm do
        click_link 'destroy'
      end
      expect(page).to have_content "Boatlog deleted"
      puts 'manager can delete boatlog'
    end
end