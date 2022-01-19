require 'rails_helper'

RSpec.describe CoralInteraction, type: :model do
  describe "new coral interaction" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @ch = create(:coral_health, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @coral = create(:coral)
      @tranc = create(:transect_coral, coral_health_id: @ch.id, coral_code_id: @coral.id)
      @int = create(:interaction)
    end
    it "is valid with valid attributes" do
      @corint = build(:coral_interaction, transect_coral_id: @tranc.id, coral_code_id: @int.id)
      expect(@corint).to be_valid
      puts 'new coral interaction is valid'
    end
    it "is not valid without a transect coral" do
      @corint = build(:coral_interaction, transect_coral_id: nil)
      expect(@corint).to_not be_valid
      puts 'coralless coral interaction is not valid'
    end
    it "is not valid without an interaction type" do
      @corint = build(:coral_interaction, coral_code_id: nil)
      expect(@corint).to_not be_valid
      puts 'interactionless coral interaction is not valid'
    end
    it "is associated with an interaction type" do
      @corint = create(:coral_interaction, transect_coral_id: @tranc.id, coral_code_id: @int.id)
      expect(@corint.coral_code.full_name).to eq("rude sponge")
      puts 'coral interaction can access interaction attributes'
    end
  end
end
