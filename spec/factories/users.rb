FactoryBot.define do
  factory :user do
    confirmed_at { Time.now }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'please123' }

    factory :user_not_confirmed do
      confirmed_at { nil }
    end
  end
end
