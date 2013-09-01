FactoryGirl.define do
  factory :track do
    title "Music track"
    description "A track of music"
    sort_order 1
    active true
    mp3 File.open(File.join(Rails.root, 'spec', 'data', 'test.mp3'))
  end
end
