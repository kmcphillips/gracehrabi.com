FactoryGirl.define do
  factory :purchase do
    webhook
    download
    sequence(:token){|n| "abc#{ n }" }
    sequence(:email){|n| "test#{ n }@example.com" }
    name "Mister Customer"
    address "123 Fake street"
  end
end
