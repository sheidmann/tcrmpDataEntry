require 'rails_helper'
require 'spec_helper'

describe "Admin views user index", type: :feature do
    before do
	    @admin = create(:admin)
	    visit('/userhome')
	    sign_in(@admin)
	end
    it "populates an array of users" do
      @user = create(:user)
      visit('/manageuser')
      expect(page).to have_content "DOE_JOHN"
      expect(page).to have_link("edit", href: edit_user_path(@user.id))
      puts 'admin can view, edit, and destroy users'
    end
end