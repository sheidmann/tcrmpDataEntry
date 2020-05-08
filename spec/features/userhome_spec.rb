require 'rails_helper'
require 'spec_helper'

describe "User visits user home", type: :feature do
	before(:each) do
	    @user = create(:user)
	    visit('/userhome')
	end
	context "(logged in)" do
	    before(:each) do
	      sign_in(@user)
	    end
		it "is sees user home" do
			expect(page).to have_content("Fish Transect")
			puts 'user login goes to userhome'
			#save_and_open_page # for debugging
	    end
	    it "cannot manage users" do
	    	expect(page).to_not have_link("Manage Users", href: "manageuser")
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
			expect(page).to_not have_content("Fish Transect")
			puts 'logged-out user cannot see user home'
		end
	end
end

describe "Manager visits user home", type: :feature do
	before do
		@manager = create(:manager)
		visit('/userhome')
		sign_in(@manager)
	end
	it "can manage boatlogs" do
		expect(page).to have_link("Boat Logs", href: '/boatlogs')
		puts 'manager can manage boatlogs'
	end
end


describe "Admin visits user home", type: :feature do
	before do
	    @admin = create(:admin)
	    visit('/userhome')
	    sign_in(@admin)
	end
	it "can manage users" do
		#save_and_open_page
		expect(page).to have_link("Manage Users", href: '/manageuser')
		puts 'admin can manage users'
	end
end