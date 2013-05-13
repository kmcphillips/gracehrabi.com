def login_as_mock_user
  u = mock_model(User)
  controller.stub!(:current_user => u)
  u
end
