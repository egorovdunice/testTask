require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET index' do
    let(:user1) { create(:user) }

    it 'show' do
      get :show, params: { id: user1.id }
      expect(response.status).to eq(200)
      expect(assigns(:count)).to eq(owner: { total: 0 }, assigned: { total: 0 })
    end
  end
end