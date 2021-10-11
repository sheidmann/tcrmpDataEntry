require 'rails_helper'

RSpec.describe FishTransect, type: :model do
  describe "new fish transect" do
  	before(:each) do
  		@manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
  	end
  	it "is valid with valid attributes" do
  		@ftran = build(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
  		expect(@ftran).to be_valid
  		puts 'new fish transect is valid'
  	end
    it "is not valid without a site" do
      @ftran = build(:fish_transect, site_id: nil)
      expect(@ftran).to_not be_valid
      puts 'siteless fish transect is not valid'
    end
    it "is not valid without a project" do
      @ftran = build(:fish_transect, manager_id: nil)
      expect(@ftran).to_not be_valid
      puts 'projectless fish transect is not valid'
    end
   	it "is not valid without a user" do
      @ftran = build(:fish_transect, user_id: nil)
      expect(@ftran).to_not be_valid
      puts 'observerless fish transect is not valid'
    end
    it "is not valid without a date" do
      @ftran = build(:fish_transect, date_completed: nil)
      expect(@ftran).to_not be_valid
      puts 'dateless fish transect is not valid'
    end
    # it "is not valid without a time" do
    #   @ftran = build(:fish_transect, begin_time: nil)
    #   expect(@ftran).to_not be_valid
    #   puts 'timeless fish transect is not valid'
    # end
    it "is not valid without a replicate number" do
      @ftran = build(:fish_transect, rep: nil)
      expect(@ftran).to_not be_valid
      puts 'repless fish transect is not valid'
    end
  end
  describe "existing fish transect" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @fish1 = create(:fish)
      @tranf1 = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish1.id)
      @fish2 = create(:fish)
      @tranf2 = create(:transect_fish, fish_transect_id: @ftran.id, fish_id: @fish2.id)
      @diadema1 = create(:diadema, fish_transect_id: @ftran.id)
      @diadema2 = create(:diadema, fish_transect_id: @ftran.id)
      @diadema3 = create(:diadema, fish_transect_id: @ftran.id)
    end
    it 'fish species can be counted' do
      expect(@ftran.countfishspecies).to equal(2)
      puts 'fish transect species can be counted'
    end
    it 'diadema can be counted' do
      expect(@ftran.countdiadema).to equal(3)
      puts 'fish transect diadema can be counted'
    end
  end
end
