class Admin::AuthorizedEmailsController < ApplicationController
  before_action :authenticate_user!

  def index
    @authorized_emails = AuthorizedEmail.order("email ASC")
  end

  def create
    @authorized_email = AuthorizedEmail.new authorized_email_params

    if @authorized_email.save
      flash[:notice] = "Email address added."
    else
      flash[:notice] = @authorized_email.errors.full_messages.to_sentence
    end

    redirect_to admin_authorized_emails_path
  end

  def destroy
    if AuthorizedEmail.find(params[:id]).try(:destroy)
      flash[:notice] = "Email address removed."
    else
      flash[:error] = "Could not remove email address."
    end

    redirect_to admin_authorized_emails_path
  end

  private

  def authorized_email_params
    params.require(:authorized_email).permit(:email)
  end

end

