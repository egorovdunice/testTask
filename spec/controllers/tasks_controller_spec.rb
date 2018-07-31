require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET index' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user, email: 'test@test.com') }
    let(:user1_task) { create(:task, owner: user1) }
    let(:user2_task) { create(:task, owner: user2) }

    before do |example|
      unless example.metadata[:skip_before]
        sign_in user1
        3.times { create(:task, owner: user1) }
        2.times { create(:task, owner: user2) }
      end
    end
    it 'redirect if not authorized', :skip_before do
      get :index
      expect(response.status).to eq(302)
      expect(response).to redirect_to('/users/sign_in')
    end
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'has only owned or assigned tasks' do
      get :index
      expect(assigns(:tasks).count).to eq(3)
      2.times { create(:task, owner: user2, assigned: user1) }
      get :index
      expect(assigns(:tasks).count).to eq(5)
    end
    it 'show belonged task card' do
      get :show, params: { id: user1_task.id }
      expect(response.status).to eq(200)
      get :show, params: { id: user2_task.id }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(tasks_path)
    end
    it 'new' do
      get :new
      expect(response.status).to eq(200)
    end
  end
  describe 'POST create' do
    it 'should create task with correct params' do
      post :create, params: { task: { title: 'abc', description: 'def', status: 'new' } }, format: :json
      expect(response.status).to eq(201)
    end
    it 'should through 422 error with incorrect params' do
      post :create, params: { task: { description: 'def', status: 'new' } }, format: :json
      expect(response.status).to eq(422)
    end
  end
  describe 'DELETE destroy' do
    it 'should redirect to /tasks with notice' do
      delete :destroy, params: { id: user1_task.id }
      expect(response).to redirect_to(tasks_path)
      expect(flash[:notice]).to eq('Task was successfully destroyed.')
    end
  end
  describe 'PATCH update' do
    it 'should update and redirect with notice' do
      patch :update, params: { id: user1_task.id, task: { title: 'test' } }
      user1_task.reload
      expect(user1_task.title).to eq('test')
      expect(response).to redirect_to(user1_task)
      expect(flash[:notice]).to eq('Task was successfully updated.')
    end
    it 'should through 422 error with incorrect params' do
      patch :update, params: { id: user1_task.id, task: { status: 'abc' } }, format: :json
      user1_task.reload
      expect(user1_task.status).to eq('new')
      expect(response.status).to eq(422)
    end
  end
end