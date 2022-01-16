require 'rails_helper'

RSpec.describe TransectCoral, type: :model do
  describe "new transect coral" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @ch = create(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @coral = create(:coral)
    end
    it "is valid with valid attributes" do
      @tranc = build(:transect_coral, coral_health_id: @ch.id, coral_code_id: @coral.id)
      expect(@tranc).to be_valid
      puts 'new transect coral is valid'
    end
    it "is not valid without a coral transect" do
      @tranc = build(:transect_coral, coral_health_id: nil)
      expect(@tranc).to_not be_valid
      puts 'transectless transect coral is not valid'
    end
    it "is not valid without a coral type" do
      @tranc = build(:transect_coral, coral_code_id: nil)
      expect(@tranc).to_not be_valid
      puts 'coralless transect coral is not valid'
    end
    it "is associated with a coral species" do
      @tranc = create(:transect_coral, coral_health_id: @ch.id, coral_code_id: @coral.id)
      expect(@tranc.coral_code.full_name).to eq("Coolus coralus")
      puts 'transect coral can access coral attributes'
    end
  end
end
