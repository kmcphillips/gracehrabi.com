shop_url = "https://#{ Settings.shopify.shared_secret }:#{ Settings.shopify.password }@gracehrabi.myshopify.com/admin"
ShopifyAPI::Base.site = shop_url
