RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

def login_as_user
  user = FactoryGirl.create(:user)
  # user = User.create! email: "example@example.com"
  sign_in user
  user
end
