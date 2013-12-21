class Admin::ContactsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @title = "Mailing list contacts"
    @emails = Contact.emails
    @date = Contact.last_updated_at
    
    @contacts = Contact.sorted
    @contacts = @contacts.search(params[:search]) if params[:search].present?
    @contacts = @contacts.page(params[:page])
  end
  
  def create
    result = Contact.add_bulk(params[:emails])
    
    flash[:notice] = "Added #{result} email addresses."
    redirect_to admin_contacts_path
  end
  
  def update
    @contact = Contact.find(params[:id])
    
    if @contact.update_attributes(contact_params)
      redirect_to admin_contacts_path, notice: "Email address updated successfully."
    else
      flash[:error] = "Could not update email address."
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:disabled)
  end

end
