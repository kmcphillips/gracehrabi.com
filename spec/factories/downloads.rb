FactoryGirl.define do
  factory :download do
    filename "the_album.zip"
    path "../shared/the_album-date.zip"
    shopify_product_id 123
    allow_anonymous false
  end
end
