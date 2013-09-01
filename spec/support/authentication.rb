def login_as_user
  controller.stub current_user: (user = FactoryGirl.create(:user))
  user
end
