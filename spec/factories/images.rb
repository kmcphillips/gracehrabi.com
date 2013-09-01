FactoryGirl.define do
  factory :image do
    label "An image"
    active true
    sort_order 1
    file File.open(File.join(Rails.root, 'spec', 'data', 'test.jpg'))
    association :gallery, factory: :gallery
  end
end
