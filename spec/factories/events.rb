FactoryGirl.define do
  factory :event do
    title "An Event"
    description "The description of an event"
    starts_at Time.now + 3.days
    price 12.00
  end
end
