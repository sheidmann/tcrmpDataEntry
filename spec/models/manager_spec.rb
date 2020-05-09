require 'rails_helper'

RSpec.describe Manager, type: :model do
  describe "new manager" do
    it "is valid with valid attributes" do
    	@manager = build(:boatlog_manager)
    	expect(@manager).to be_valid
      puts 'new manager is valid'
    end
    it "is not valid without a name" do
    	@manager = build(:boatlog_manager, manager_name: nil)
    	expect(@manager).to_not be_valid
      puts 'nameless manager is not valid'
    end
    it "is not valid without a project" do
    	@manager = build(:boatlog_manager, project: nil)
    	expect(@manager).to_not be_valid
      puts 'projectless manager is not valid'
    end
  end
end
