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
end
