require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) { { first_name: 'Alex', last_name: 'Tester', email: 'alex@test.com', password: '123456' } }

  it 'is valid with valid attributes' do
    user = User.new(user_params)
    expect(user).to be_valid
  end
  it 'is not valid without a first_name' do
    user_params.delete(:first_name)
    user = User.new(user_params)
    expect(user).to_not be_valid
  end
  it 'is not valid without a last_name' do
    user_params.delete(:last_name)
    user = User.new(user_params)
    expect(user).to_not be_valid
  end
  it 'is not valid without a email' do
    user_params.delete(:email)
    user = User.new(user_params)
    expect(user).to_not be_valid
  end
  it 'is not valid without a password' do
    user_params.delete(:password)
    user = User.new(user_params)
    expect(user).to_not be_valid
  end
  it 'has many tasks' do
    association = described_class.reflect_on_association(:tasks)
    expect(association.macro).to eq :has_many
  end
end