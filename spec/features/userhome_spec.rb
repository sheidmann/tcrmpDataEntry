require 'rails_helper'
require 'spec_helper'

describe "User visiting user home", type: :feature do
	before(:each) do
	    @user = create(:user)
	    visit('/userhome')
	end
	context "(logged in)" do
	    before(:each) do
	      sign_in(@user)
	    end
		it "sees user home" do
			expect(page).to have_selector(:link_or_button, "Fish Transect")
			puts 'user login goes to userhome'
			#save_and_open_page # for debugging
	    end
	    it "cannot manage users" do
	    	expect(page).to_not have_selector(:link_or_button, "Manage Users")
	    	puts 'user cannot manage users'
	    end
	    it "can log out" do
	    	expect(page).to have_link("Log out", href: logout_path)
	    	puts 'user can log out'
	    end
	    it "cannot log in" do
	    	expect(page).to_not have_link("Log in", href: '/login')
	    	puts 'logged-in user cannot log in'
	    end
	end
	context "(logged out)" do
		it "does not see user home" do
			expect(page).to_not have_selector(:link_or_button, "Fish Transect")
			puts 'logged-out user cannot see user home'
		end
	end
end

describe "Manager visiting user home", type: :feature do
	before do
		@manager = create(:manager)
		visit('/userhome')
		sign_in(@manager)
	end
	it "can manage boatlogs" do
		expect(page).to have_selector(:link_or_button, "Boat Logs")
		puts 'manager can manage boatlogs'
	end
end

describe "Admin visiting user home", type: :feature do
	before do
	    @admin = create(:admin)
	    visit('/userhome')
	    sign_in(@admin)
	end
	it "can manage users" do
		#save_and_open_page
		expect(page).to have_selector(:link_or_button, "Manage Users")
		puts 'admin can manage users'
	end
end