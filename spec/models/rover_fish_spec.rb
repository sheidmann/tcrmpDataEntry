require 'rails_helper'

RSpec.describe RoverFish, type: :model do
  describe "new rover fish" do
  	before(:each) do
			@manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @frove = create(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @fish = create(:fish)
  	end
  	it "is valid with valid attributes" do
  		@rovef = build(:rover_fish, fish_rover_id: @frove.id, fish_id: @fish.id)
  		expect(@rovef).to be_valid
  		puts 'new rover fish is valid'
  	end
  	it "is not valid without a fish rover" do
      @rovef = build(:rover_fish, fish_rover_id: nil)
      expect(@rovef).to_not be_valid
      puts 'roverless rover fish is not valid'
    end
    it "is not valid without a fish type" do
      @rovef = build(:rover_fish, fish_id: nil)
      expect(@rovef).to_not be_valid
      puts 'fishless rover fish is not valid'
    end
    it "is associated with a fish species" do
    	@rovef = create(:rover_fish, fish_rover_id: @frove.id, fish_id: @fish.id)
    	expect(@rovef.fish.scientific_name).to eq("Coolus fishus")
    	puts 'rover fish can access fish attributes'
  	end
  end
end
