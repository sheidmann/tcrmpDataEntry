require 'rails_helper'

RSpec.describe Boatlog, type: :model do
  describe "new boatlog" do
  	before(:each) do
  		@manager = create(:manager)
  	end
    it "is valid with valid attributes" do
    	@boatlog = build(:boatlog, manager_name: @manager.name)
    	expect(@boatlog).to be_valid
      puts 'new boatlog is valid'
    end
    it "is not valid without a site" do
    	@boatlog = build(:boatlog, site: nil)
    	expect(@boatlog).to_not be_valid
      puts 'siteless boatlog is not valid'
    end
    it "is not valid without a date" do
    	@boatlog = build(:boatlog, date_completed: nil)
    	expect(@boatlog).to_not be_valid
      puts 'dateless boatlog is not valid'
    end
    it "is not valid without a manager" do
    	@boatlog = build(:boatlog, manager_name: nil)
    	expect(@boatlog).to_not be_valid
      puts 'managerless boatlog is not valid'
    end
    it 'is not valid if site/date/time is not unique' do
    	@boatlog1 = create(:boatlog)
    	@boatlog2 = build(:boatlog)
    	expect(@boatlog2).to_not be_valid
    	puts 'duplicate boatlog is not valid'
    end
    it 'is valid if site repeated in a day' do
    	@boatlog1 = create(:boatlog, begin_time: Time.parse("09:00Z"))
    	@boatlog2 = build(:boatlog, begin_time: Time.parse("10:00Z"))
    	expect(@boatlog2).to be_valid
    	puts 'repeated site is valid'
    end
  end
end
