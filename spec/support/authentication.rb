def login_as_user
  controller.stub current_user: (user = double(User))
  user
end
