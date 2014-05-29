FactoryGirl.define do
  factory :webhook do
    body({topic: 'orders/create', id: 314}.to_json)
  end
end
