require 'rails_helper'

RSpec.describe Site, type: :model do
  describe "new site" do
  	it "is valid with valid attributes" do
  		@site = build(:site)
  		expect(@site).to be_valid
  		puts 'new site is valid'
  	end
  	it "is not valid without a name" do
  		@site = build(:site, site_name: nil)
  		expect(@site).to_not be_valid
  		puts 'nameless site is not valid'
  	end
  	it "is not valid with a duplicate name" do
  		@site1 = create(:site)
  		@site2 = build(:site)
  		expect(@site2).to_not be_valid
  		puts 'duplicate site is not valid'
  	end
  end
  describe "existing site" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @boatlog = create(:boatlog, manager_id: @blmanager.id, site_id: @site.id)
      @observer = create(:user)
      @surveytype = create(:survey_type, type_name: "fish transect")
      @survey1 = create(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id)
      @survey2 = create(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id, rep: 2)
    end
    it "can count fish transects" do
      expect(@site.fishtrancount).to equal(2)
      puts 'site fish transects can be counted'
    end
  end
end
