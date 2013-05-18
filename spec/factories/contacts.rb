FactoryGirl.define do
  factory :contact do
    sequence(:email){|n| "test#{n}@example.com" }
    disabled false
  end
end
