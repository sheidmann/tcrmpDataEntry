require 'rails_helper'

RSpec.describe CoralCode, type: :model do
  describe "new coral" do
    it "is valid with valid attributes" do
      @coral = build(:coral)
      expect(@coral).to be_valid
      puts 'new coral is valid'
    end
    it "has a searchable name" do
      @coral = create(:coral)
      @name = @coral.combo_name
      expect(@name).to eq("CC __ Coolus coralus")
      puts 'new coral has a searchable name'
    end
    it "is not valid without a full name" do
      @coral = build(:coral, full_name: nil)
      expect(@coral).to_not be_valid
      puts 'full-nameless coral is not valid'
    end
    it "is not valid without a code name" do
      @coral = build(:coral, code_name: nil)
      expect(@coral).to_not be_valid
      puts 'code-nameless coral is not valid'
    end
  end
  describe "new interaction" do
    it "is valid with valid attributes" do
      @int = build(:interaction)
      expect(@int).to be_valid
      puts 'new interaction is valid'
    end
    it "has a searchable name" do
      @int = create(:interaction)
      @name = @int.combo_name
      expect(@name).to eq("RS __ rude sponge")
      puts 'new interaction has a searchable name'
    end
    it "is not valid without a full name" do
      @int = build(:interaction, full_name: nil)
      expect(@int).to_not be_valid
      puts 'full-nameless interaction is not valid'
    end
    it "is not valid without a code name" do
      @int = build(:interaction, code_name: nil)
      expect(@int).to_not be_valid
      puts 'code-nameless interaction is not valid'
    end
  end
end
