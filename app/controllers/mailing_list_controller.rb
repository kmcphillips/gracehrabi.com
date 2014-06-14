class MailingListController < ApplicationController

  def index
    @title = "Mailing list sign up"
  end

  def create
    @contact = Contact.build_from_email(params[:email])
    @contact.source = "website"

    if @contact.save
      flash[:notice] = "You have been signed up! Thank you!"
      redirect_to root_path
    else
      render :index
    end
  end
  
  def show
    @contact = Contact.find_by_token(params[:id])
    @title = "Unsubscribe"
  end
  
  def destroy
    @contact = Contact.find_by_token_and_disabled!(params[:id], false)
    @contact.disable
    @title = "Unsubscribe success"
  end

end
