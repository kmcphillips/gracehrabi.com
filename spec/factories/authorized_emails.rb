FactoryGirl.define do
  factory :authorized_email do
    sequence(:email) {|n| "authorized_email#{ n }@example.com" }
  end
end
