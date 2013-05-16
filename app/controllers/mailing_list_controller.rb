class MailingListController < ApplicationController

  def index
    @title = "Mailing list sign up"
  end

  def create
    @contact = Contact.find_by_email(params[:email]) || Contact.new(email: params[:email])
    @contact.disabled = false
    
    if @contact.save
      flash[:notice] = "You have been signed up! Thank you!"
    end

    render :index
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
