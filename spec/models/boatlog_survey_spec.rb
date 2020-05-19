require 'rails_helper'

RSpec.describe BoatlogSurvey, type: :model do
  describe "new boatlog survey" do
  	before(:each) do
  		@manager = create(:manager)
    	@blmanager = create(:boatlog_manager, user_id: @manager.id)
    	@boatlog = create(:boatlog, manager_id: @blmanager.id)
    	@observer = create(:user)
    	@surveytype = create(:survey_type)
    end
    it "is valid with valid attributes" do
    	@survey = build(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id)
    	expect(@survey).to be_valid
    	puts "new boatlog survey is valid"
    end
    it 'is not valid if boatlog/observer/type/rep combo is not unique' do
    	@survey1 = create(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id)
    	@survey2 = build(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id)
    	expect(@survey2).to_not be_valid
    	puts 'duplicate survey is not valid'
    end
    it "can access observer name" do
        @survey = build(:boatlog_survey, boatlog_id: @boatlog.id, user_id: @observer.id, survey_type_id: @surveytype.id)
        expect(@survey.user.name).to eq("DOE_JOHN")
        puts "belongs to a user"
    end
  end
end
