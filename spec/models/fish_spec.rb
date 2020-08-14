require 'rails_helper'

RSpec.describe Fish, type: :model do
  describe "new fish" do
  	it "is valid with valid attributes" do
  		@fish = build(:fish)
  		expect(@fish).to be_valid
  		puts 'new fish is valid'
  	end
  	it "has a searchable name" do
  		@fish = create(:fish)
  		@name = @fish.spp_code_common
  		expect(@name).to eq("COO FISH __ the coolest fish")
  		puts 'new fish has a searchable name'
  	end
    it "is not valid without a common name" do
      @fish = build(:fish, common_name: nil)
      expect(@fish).to_not be_valid
      puts 'common-nameless fish is not valid'
    end
    it "is not valid without a scientific name" do
      @fish = build(:fish, scientific_name: nil)
      expect(@fish).to_not be_valid
      puts 'scientific-nameless fish is not valid'
    end
    it "is not valid without a code name" do
      @fish = build(:fish, code_name: nil)
      expect(@fish).to_not be_valid
      puts 'code-nameless fish is not valid'
    end
  end
end
