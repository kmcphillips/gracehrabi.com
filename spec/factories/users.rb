FactoryGirl.define do
  factory :user do
    username "exampleuser"
    password_hash "12341234"
    name "Example User"
    email "example@user.com"
  end
end
