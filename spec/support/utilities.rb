require 'rails_helper'
require 'spec_helper'

def sign_in(user)
  #visit '/login'
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Log in"
  # Sign in when not using Capybara as well.
  #cookies[:remember_token] = user.remember_token
end

def sign_out(user)
  click_link "Log out"
end

def sign_in_user(user)
	#@user = FactoryBot.create(:user)
	allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
end