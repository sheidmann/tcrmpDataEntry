require 'spec_helper'
class Home
  include Capybara::DSL
  def visit_homepage
    visit('/')
  end
end
feature "Visitor visits homepage" do
  let(:home) {Home.new}
  scenario "Able to see text", :js => true do
    home.visit_homepage
    expect(page).to have_content("TCRMP Data Entry")
    puts 'homepage has content'
  end
  scenario "Can log in", :js => true do
    home.visit_homepage
    expect(page).to have_link("Log in", href: "login")
    puts 'visitor can log in'
  end
end