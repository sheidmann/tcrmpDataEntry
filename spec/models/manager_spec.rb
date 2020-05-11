require 'rails_helper'

RSpec.describe Manager, type: :model do
  describe "new manager" do
    before(:each) do
      @manager = create(:manager)
    end
    it "is valid with valid attributes" do
      @blmanager = build(:boatlog_manager, user_id: @manager.id)
    	expect(@blmanager).to be_valid
      puts 'new manager is valid'
    end
    it "is not valid without a user id" do
    	@blmanager = build(:boatlog_manager, user_id: nil)
    	expect(@blmanager).to_not be_valid
      puts 'userless manager is not valid'
    end
    it "is not valid without a project" do
    	@blmanager = build(:boatlog_manager, user_id: @manager.id, project: nil)
    	expect(@blmanager).to_not be_valid
      puts 'projectless manager is not valid'
    end
    it "has an associated user" do
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      expect(@blmanager.user).to_not be_nil
      puts 'new manager has associated user'
    end
  end
end
