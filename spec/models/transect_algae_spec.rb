require 'rails_helper'

RSpec.describe TransectAlgae, type: :model do
  describe "new transect algae" do
    before(:each) do
      @manager = create(:manager)
      @blmanager = create(:boatlog_manager, user_id: @manager.id)
      @site = create(:site)
      @aht = create(:algae_height, manager_id: @blmanager.id, site_id: @site.id, user_id: @manager.id)
      @algae = create(:algae)
    end
    it "is valid with valid attributes" do
      @trana = build(:transect_algae, algae_height_id: @aht.id, algae_id: @algae.id)
      expect(@trana).to be_valid
      puts 'new transect algae is valid'
    end
    it "is not valid without an algae transect" do
      @trana = build(:transect_algae, algae_height_id: nil)
      expect(@trana).to_not be_valid
      puts 'transectless transect algae is not valid'
    end
    it "is not valid without an algae type" do
      @trana = build(:transect_algae, algae_id: nil)
      expect(@trana).to_not be_valid
      puts 'algaeless transect algae is not valid'
    end
    it "is associated with an algae species" do
      @trana = create(:transect_algae, algae_height_id: @aht.id, algae_id: @algae.id)
      expect(@trana.algae.full_name).to eq("wavy plant stuff")
      puts 'transect algae can access algae attributes'
    end
  end
end
