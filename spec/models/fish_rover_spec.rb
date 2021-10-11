require 'rails_helper'

RSpec.describe FishRover, type: :model do
  describe "new fish rover" do
  	before(:each) do
  		@manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
  	end
  	it "is valid with valid attributes" do
  		@frove = build(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
  		expect(@frove).to be_valid
  		puts 'new fish rover is valid'
  	end
  	it "is not valid without a site" do
      @frove = build(:fish_rover, site_id: nil)
      expect(@frove).to_not be_valid
      puts 'siteless fish rover is not valid'
    end
    it "is not valid without a project" do
      @frove = build(:fish_rover, manager_id: nil)
      expect(@frove).to_not be_valid
      puts 'projectless fish rover is not valid'
    end
   	it "is not valid without a user" do
      @frove = build(:fish_rover, user_id: nil)
      expect(@frove).to_not be_valid
      puts 'observerless fish rover is not valid'
    end
    it "is not valid without a date" do
      @frove = build(:fish_rover, date_completed: nil)
      expect(@frove).to_not be_valid
      puts 'dateless fish rover is not valid'
    end
    # it "is not valid without a time" do
    #   @frove = build(:fish_rover, begin_time: nil)
    #   expect(@frove).to_not be_valid
    #   puts 'timeless fish rover is not valid'
    # end
    it "is not valid without a replicate number" do
      @frove = build(:fish_rover, rep: nil)
      expect(@frove).to_not be_valid
      puts 'repless fish rover is not valid'
    end
  end
  describe "existing fish rover" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @frove = create(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @fish1 = create(:fish)
      @rovef1 = create(:rover_fish, fish_rover_id: @frove.id, fish_id: @fish1.id)
      @fish2 = create(:fish)
      @rovef2 = create(:rover_fish, fish_rover_id: @frove.id, fish_id: @fish2.id)
    end
    it 'fish species can be counted' do
      expect(@frove.countfishspecies).to equal(2)
      puts 'fish rover species can be counted'
    end
  end
end
