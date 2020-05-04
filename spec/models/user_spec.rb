require 'rails_helper'

RSpec.describe User, type: :model do
  describe "new user" do
    it "is valid with valid attributes" do
    	@user1 = build(:user)
    	expect(@user1).to be_valid
      puts 'new user is valid'
    end
    it "has a unique username" do
    	@user1 = create(:user)
    	@user2 = build(:user, username: "doe_john")
    	expect(@user2).to_not be_valid
      puts 'new user is unique'
    end
    it "is not valid without a name" do
    	@user2 = build(:user, name: nil)
    	expect(@user2).to_not be_valid
      puts 'nameless user is not valid'
    end
    it "is not valid without a role" do
    	@user2 = build(:user, role: nil)
    	expect(@user2).to_not be_valid
      puts 'roleless user is not valid'
    end
  end

  describe "admin" do
    it "is an admin" do
      @user_admin = build_stubbed(:admin)
      expect(@user_admin.admin?).to be true
      puts 'admin is an admin'
    end
  end

  describe "manager" do
    it "is a manager" do
      @user_manager = build_stubbed(:manager)
      expect(@user_manager.manager?).to be true
      puts 'manager is a manager'
    end
  end

  describe "inactive" do
    it "is inactive" do
      @user_inactive = build_stubbed(:user, active: "false")
      expect(@user_inactive.active?).to be false
      puts 'inactive user is inactive'
    end
  end
end
