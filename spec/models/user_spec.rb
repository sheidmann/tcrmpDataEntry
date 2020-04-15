require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
  	user1 = create(:user)
  	expect(user1).to be_valid
  end
  it "has a unique username" do
  	user1 = create(:user)
  	user2 = build(:user, username: "doe_john")
  	expect(user2).to_not be_valid
  end
  it "is not valid without a name" do
  	user2 = build(:user, name: nil)
  	expect(user2).to_not be_valid
  end
  it "is not valid without a role" do
  	user2 = build(:user, role: nil)
  	expect(user2).to_not be_valid
  end
end
