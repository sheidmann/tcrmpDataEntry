require 'spec_helper'
require 'rails_helper'

feature "Visitor visits homepage" do
  scenario "Able to see text", :js => true do
    visit('/')
    expect(page).to have_content("TCRMP Data Entry")
    puts 'homepage has content'
  end
  scenario "Can log in", :js => true do
    visit('/')
    expect(page).to have_link("Log in", href: "login")
    puts 'visitor can log in'
  end
end