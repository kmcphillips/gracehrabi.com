class MailingListController < FrontEndController

  def index
  end

  def create
    @contact = Contact.build_from_email(params[:email])
    @contact.source = "website"

    if @contact.save
      flash[:notice] = "You have been signed up! Thank you!"
      redirect_to :back
    else
      flash[:error] = "There was an error adding you to the mailing list. #{ @contact.errors.full_messages.to_sentence }"
      redirect_to :back
    end
  end
  
  def show
    @contact = Contact.find_by_token(params[:id])

    if @contact
      @title = "Unsubscribe"
    else
      flash[:error] = "Could not find email to unsubscribe."
      redirect_to root_path
    end
  end
  
  def destroy
    @contact = Contact.find_by_token_and_disabled!(params[:id], false)
    @contact.disable
    @title = "Unsubscribe success"
  end

end
