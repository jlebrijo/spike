FactoryBot.define do
  factory :user do
    confirmed_at { Time.now }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'please123' }
  end
end
