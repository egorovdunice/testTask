# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name 'Alex'
    last_name 'Tester'
    email 'alex@test.com'
    password '123456'
  end
end