require 'rails_helper'
require 'spec_helper'

describe "Admin viewing user index", :js => true, type: :feature do
  before(:each) do
    @admin = create(:admin)
    visit('/userhome')
    sign_in(@admin)
  end
  it "sees an array of users" do
    @user = create(:user)
    visit('/users')
    expect(page).to have_content "DOE_JOHN"
    expect(page).to have_link("edit", href: edit_user_path(@user.id))
    puts 'admin can view users with option to edit'
  end
  it "can create a user" do
    visit('/users')
    click_button("New User")
    expect(page).to have_content 'Privileges'

    @user = build(:user)
    fill_in "Name", with: @user.name
    fill_in "Email", with: @user.email
    select @user.role, :from => "Privileges"
    select @user.agency, :from => "Agency"
    select @user.active, :from => "Active?"
    
    expect { click_button('Add User') }.to change(User, :count).by(+1)
    expect(page).to have_content "User successfully created"
    puts 'admin can create user'
  end
  it "can edit a user" do
    @user = create(:user)
    visit('/users')

    find("a[href='#{edit_user_path(@user.id)}']").click
    expect(page).to have_content("Edit User")
    expect(page).to have_selector(:link_or_button, "Update User")

    click_button("Update User")
    expect(page).to have_content "User successfully updated"
    puts 'admin can edit user'
  end
  it "can delete a user" do
    @user = create(:user)
    visit('/users')
    accept_confirm do
        click_link("destroy")
    end
    expect(page).to have_content "User deleted"
    puts "admin can delete user"
  end
end