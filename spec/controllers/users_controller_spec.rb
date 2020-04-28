require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end
	# describe 'GET #index' do
	#   before do
	#     @users = [build_stubbed(:user)]
	#     allow(User).to receive(:all).and_return(@users)
	#     get "index"
	#   end  

	#   it 'populates a table of all users' do
	#     expect(assigns(:users)).to match_array(@users)  
	#   end
	# end
end