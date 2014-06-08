FactoryGirl.define do
  factory :download do
    name "The Album"
    filename "the_album.zip"
    path "../shared/the_album-date.zip"
    image_path "images/the-album.png"
    shopify_product_id 312 # from webhooks/order_creation.json
    allow_anonymous false
  end
end
