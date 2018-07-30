require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }
  let(:task_params) { { title: 'test', description: 'test', status: 'new', owner_id: user.id } }

  it 'is valid with valid attributes' do
    task = Task.new(task_params)
    expect(task).to be_valid
  end
  it 'is not valid without a title' do
    task_params.delete(:title)
    task = Task.new(task_params)
    expect(task).to_not be_valid
  end
  it 'is not valid without a description' do
    task_params.delete(:description)
    task = Task.new(task_params)
    expect(task).to_not be_valid
  end
  it 'is not valid without a status' do
    task_params.delete(:status)
    task = Task.new(task_params)
    expect(task).to_not be_valid
  end
  it 'is not valid with wrong status' do
    task_params[:status] = 'wrong status'
    task = Task.new(task_params)
    expect(task).to_not be_valid
  end
  it 'belongs to one owner' do
    association = described_class.reflect_on_association(:owner)
    expect(association.macro).to eq :belongs_to
  end
  it 'belongs to assigned user' do
    association = described_class.reflect_on_association(:assigned)
    expect(association.macro).to eq :belongs_to
  end
end