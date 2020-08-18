require 'rails_helper'

RSpec.describe TransectFish, type: :model do
  describe "new transect fish" do
  	before(:each) do
  		@manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @fish = create(:fish)
  	end
  	it "is valid with valid attributes" do
  		@tranf = build(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish.id)
  		expect(@tranf).to be_valid
  		puts 'new transect fish is valid'
  	end
  	it "is not valid without a fish transect" do
      @tranf = build(:transect_fish, fish_transect_id: nil)
      expect(@tranf).to_not be_valid
      puts 'transectless transect fish is not valid'
    end
    it "is not valid without a fish type" do
      @tranf = build(:transect_fish, fish_id: nil)
      expect(@tranf).to_not be_valid
      puts 'fishless transect fish is not valid'
    end
    it "is associated with a fish species" do
    	@tranf = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish.id)
    	expect(@tranf.fish.scientific_name).to eq("Coolus fishus")
    	puts 'transect fish can access fish attributes'
  	end
  end
  describe "existing transect fish" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @fish = create(:fish)
      @tranf = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish.id)
    end
    it "has a species total" do
      @tranf = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish.id)
      expect(@tranf.speciestotal).to equal(11)
      puts 'transect fish has total count'
    end
  end
end
