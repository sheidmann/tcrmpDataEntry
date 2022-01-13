require 'rails_helper'

RSpec.describe Algae, type: :model do
  describe "new algae" do
    it "is valid with valid attributes" do
      @algae = build(:algae)
      expect(@algae).to be_valid
      puts 'new algae is valid'
    end
    it "has a searchable name" do
      @algae = create(:algae)
      @name = @algae.combo_name
      expect(@name).to eq("ALG __ wavy plant stuff")
      puts 'new algae has a searchable name'
    end
    it "is not valid without a full name" do
      @algae = build(:algae, full_name: nil)
      expect(@algae).to_not be_valid
      puts 'full-nameless algae is not valid'
    end
    it "is not valid without a code name" do
      @algae = build(:algae, code_name: nil)
      expect(@algae).to_not be_valid
      puts 'code-nameless algae is not valid'
    end
  end
end
