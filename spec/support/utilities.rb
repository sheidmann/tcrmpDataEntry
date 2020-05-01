def sign_in(user)
  #visit '/login'
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Log in"
  # Sign in when not using Capybara as well.
  #cookies[:remember_token] = user.remember_token
end