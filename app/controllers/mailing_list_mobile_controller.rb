class MailingListMobileController < ApplicationController
  layout "mobile"
  
  def index
    @title = "Mailing List"
  end

  def create
    @contact = Contact.build_from_email(params[:email])
    
    if @contact.save
      flash[:notice] = "You have been signed up! Thank you!"
      redirect_to mailing_list_mobile_index_path
    else
      flash[:error] = "Error: #{ @contact.errors.full_messages.to_sentence }"
      render :index
    end
  end
  
end
