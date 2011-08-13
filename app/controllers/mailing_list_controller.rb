class MailingListController < ApplicationController

  def index
    @title = "Mailing list sign up"
  end

  def create
    @contact = Contact.find_by_email(params[:email]) || Contact.new(:email => params[:email])

    if @contact.save
      flash[:notice] = "You have been signed up! Thank you!"
    end

    render :index
  end

end
