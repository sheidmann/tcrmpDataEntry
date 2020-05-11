require 'rails_helper'
require 'spec_helper'

describe "Admin viewing manager index", :js => true, type: :feature do
  before(:each) do
    @admin = create(:admin)
    visit('/login')
    sign_in(@admin)
  end
  it "sees an array of managers" do
    @manager = create(:boatlog_manager)
    visit('/managers')
    expect(page).to have_content "DOE_JACK"
    expect(page).to have_link("edit", href: edit_manager_path(@manager.id))
    puts 'admin can view managers with option to edit'
  end
  it "can create a manager" do
    @manager = create(:manager) # create manager to select
    visit('/managers')
    click_button("New Manager")
    expect(page).to have_content "Project"

    select @manager.name, :from => "Name"
    fill_in "Project", with: "My Project"
    click_button "Add Manager"
    expect(page).to have_content "Manager successfully created"
    puts "admin can create a new manager"
  end
  it "can edit a manager" do
    @manager = create(:boatlog_manager)
    visit('/managers')

    click_link('edit')
    expect(page).to have_content("Edit Manager")
    expect(page).to have_selector(:link_or_button, "Update Manager")

    click_button("Update Manager")
    expect(page).to have_content "Manager successfully updated"
    puts 'admin can edit manager'
  end
  it "can delete a manager" do
    @manager = create(:boatlog_manager)
    visit('managers')
    accept_confirm do
      click_link 'destroy'
    end
    expect(page).to have_content "Manager deleted"
    puts "admin can delete manager"
  end
end