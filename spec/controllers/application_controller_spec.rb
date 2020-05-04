require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
	it "should have a current user" do 
		@user = FactoryBot.create(:user)
		sign_in_user(@user)
		puts "user role is #{@user.role}"
	end
	it "should have a current admin" do
		@admin = FactoryBot.create(:admin)
		sign_in_user(@admin)
		puts "admin role is #{@admin.role}"
	end
end