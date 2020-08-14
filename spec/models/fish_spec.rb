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
  end
end
