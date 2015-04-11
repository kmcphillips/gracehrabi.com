class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_or_request_with_http_basic

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if !@user.authorized?
      flash[:error] = "Your email address has not been authorized."
      redirect_to new_user_session_path
    elsif @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      remember_me(@user)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = "There was an error creating your user."
      redirect_to new_user_session_path
    end
  end

end
