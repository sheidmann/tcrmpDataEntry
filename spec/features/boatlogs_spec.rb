require 'rails_helper'
require 'spec_helper'

describe "Manager views boatlog index", type: :feature do
    before do
	    @manager = create(:manager)
	    visit('/login')
	    sign_in(@manager)
	end
    it "populates an array of boatlogs" do
      @boatlog = create(:boatlog, site: "My Site")
      visit('/boatlogs')
      expect(page).to have_content "My Site"
      expect(page).to have_link("edit", href: edit_boatlog_path(@boatlog.id))
      puts 'manager can view, edit, and destroy boatlogs'
    end
end