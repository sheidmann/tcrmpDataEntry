require 'rails_helper'

RSpec.describe CoralHealth, type: :model do
  describe "new coral health" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
    end
    it "is valid with valid attributes" do
      @ch = build(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      expect(@ch).to be_valid
      puts 'new coral health is valid'
    end
    it "is not valid without a site" do
      @ch = build(:coral_health, site_id: nil)
      expect(@ch).to_not be_valid
      puts 'siteless coral health is not valid'
    end
    it "is not valid without a project" do
      @ch = build(:coral_health, manager_id: nil)
      expect(@ch).to_not be_valid
      puts 'projectless coral health is not valid'
    end
    it "is not valid without a user" do
      @ch = build(:coral_health, user_id: nil)
      expect(@ch).to_not be_valid
      puts 'observerless coral health is not valid'
    end
    it "is not valid without a date" do
      @ch = build(:coral_health, date_completed: nil)
      expect(@ch).to_not be_valid
      puts 'dateless coral health is not valid'
    end
    it "is not valid without a replicate number" do
      @ch = build(:coral_health, rep: nil)
      expect(@ch).to_not be_valid
      puts 'repless coral health is not valid'
    end
  end
end
