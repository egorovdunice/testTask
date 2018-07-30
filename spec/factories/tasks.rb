# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title 'Test Title'
    description 'Test Description'
    status 'new'
    owner_id 1
  end
end