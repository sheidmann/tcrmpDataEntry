require 'rails_helper'

RSpec.describe FishRover, type: :model do
  describe "new fish rover" do
  	before(:each) do
  		@manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
  	end
  	it "is valid with valid attributes" do
  		@frov = build(:fish_rover, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
  		expect(@frov).to be_valid
  		puts 'new fish rover is valid'
  	end
  	it "is not valid without a site" do
      @frov = build(:fish_rover, site_id: nil)
      expect(@frov).to_not be_valid
      puts 'siteless fish rover is not valid'
    end
    it "is not valid without a project" do
      @frov = build(:fish_rover, manager_id: nil)
      expect(@frov).to_not be_valid
      puts 'projectless fish rover is not valid'
    end
   	it "is not valid without a user" do
      @frov = build(:fish_rover, user_id: nil)
      expect(@frov).to_not be_valid
      puts 'observerless fish rover is not valid'
    end
    it "is not valid without a date" do
      @frov = build(:fish_rover, date_completed: nil)
      expect(@frov).to_not be_valid
      puts 'dateless fish rover is not valid'
    end
    it "is not valid without a time" do
      @frov = build(:fish_rover, begin_time: nil)
      expect(@frov).to_not be_valid
      puts 'timeless fish rover is not valid'
    end
    it "is not valid without a replicate number" do
      @frov = build(:fish_rover, rep: nil)
      expect(@frov).to_not be_valid
      puts 'repless fish rover is not valid'
    end
  end
end
