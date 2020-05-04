require 'spec_helper'
require 'rails_helper'

describe "user logs in and out(valid)", type: :feature do
	before(:each) do
		@user = create(:user)
		visit('/login')
		sign_in(@user)
	end
	it "logs in successfully" do
		expect(page).to have_content("Logged in successfully")
		puts 'user logs in successfully'
	end
	it "logs out successfully" do
		sign_out(@user)
		expect(page).to have_content("Logged out successfully")
		puts 'user logs out successfully'
	end
end
describe "user logs in (invalid)", type: :feature do
	before(:each) do
		visit('/login')
	end
	it "user does not exist in database" do
		@user = build(:user)
		sign_in(@user)
		expect(page).to have_content("Error: user does not exist")
		puts 'non-user cannot log in'
	end
	it "user is inactive" do
		@user = create(:user, active: "false")
		sign_in(@user)
		expect(page).to have_content("Error: user exists but is inactive")
		puts 'inactive user cannot log in'
	end
end