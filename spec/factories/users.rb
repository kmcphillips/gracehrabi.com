FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{ n }@example.com" }
    password { Devise.friendly_token[0,20] }
  end
end
