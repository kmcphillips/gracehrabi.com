class Admin::ContactsController < ApplicationController
  before_filter :require_login
  
  def index
    @title = "Mailing list contacts"
    @contacts = Contact.paginate(pagination_params)
    @emails = Contact.emails
    @date = Contact.last_updated_at
  end
  
  def update
    # TODO
  end
  
end
