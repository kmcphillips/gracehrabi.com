class Admin::ContactsController < ApplicationController
  before_filter :require_login
  
  def index
    @title = "Mailing list contacts"
    @contacts = Contact.sorted.paginate(pagination_params)
    @emails = Contact.emails
    @date = Contact.last_updated_at
  end
  
  def create
    result = Contact.add_bulk(params[:emails])
    
    flash[:notice] = "Added #{result} email addresses."
    redirect_to admin_contacts_path
  end
  
  def update
    @contact = Contact.find(params[:id])
    
    if @contact.update_attributes(params[:contact])
      redirect_to admin_contacts_path, notice: "Email address updated successfully."
    else
      flash[:error] = "Could not update email address."
    end
  end
  
end
