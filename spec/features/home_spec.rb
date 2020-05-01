require 'spec_helper'
class Home
  include Capybara::DSL
  def visit_homepage
    visit('/')
  end
end
feature "Visit homepage" do
  let(:home) {Home.new}
  scenario "Able to see text", :js => true do
    home.visit_homepage
    expect(page).to have_content("TCRMP Data Entry")
    puts 'homepage has content'
  end
end