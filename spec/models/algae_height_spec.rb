require 'rails_helper'

RSpec.describe AlgaeHeight, type: :model do
  describe "new algae height" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
    end
    it "is valid with valid attributes" do
      @aht = build(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      expect(@aht).to be_valid
      puts 'new algae height is valid'
    end
    it "is not valid without a site" do
      @aht = build(:algae_height, site_id: nil)
      expect(@aht).to_not be_valid
      puts 'siteless algae height is not valid'
    end
    it "is not valid without a project" do
      @aht = build(:algae_height, manager_id: nil)
      expect(@aht).to_not be_valid
      puts 'projectless algae height is not valid'
    end
    it "is not valid without a user" do
      @aht = build(:algae_height, user_id: nil)
      expect(@aht).to_not be_valid
      puts 'observerless algae height is not valid'
    end
    it "is not valid without a date" do
      @aht = build(:algae_height, date_completed: nil)
      expect(@aht).to_not be_valid
      puts 'dateless algae height is not valid'
    end
    it "is not valid without a replicate number" do
      @aht = build(:algae_height, rep: nil)
      expect(@aht).to_not be_valid
      puts 'repless algae height is not valid'
    end
  end
end
