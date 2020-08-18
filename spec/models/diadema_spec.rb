require 'rails_helper'

RSpec.describe Diadema, type: :model do
  describe "new diadema" do
  	before(:each) do
  		@manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @ftran = create(:fish_transect, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
  	end
  	it "is valid with valid attributes" do
  		@diadema = build(:diadema, fish_transect_id: @ftran.id)
  		expect(@diadema).to be_valid
  		puts 'new diadema is valid'
  	end
  	it "is not valid without a fish transect" do
      @diadema = build(:diadema, fish_transect_id: nil)
      expect(@diadema).to_not be_valid
      puts 'transectless diadema is not valid'
    end
  end
end
