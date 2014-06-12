# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :download_record do
    download_id 1
    purchase_id 1
    ip_address "MyString"
    useragent "MyString"
    token "MyString"
  end
end
