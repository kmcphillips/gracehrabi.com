class AdminMailer < ActionMailer::Base
  default :from => ROBOT_EMAIL

  def contact_request(opts)
    subject = "TODO"

    mail(:to => site_email, :subject => "Contact request: #{subject}")
  end

  protected

  def admin_email
    ADMIN_EMAIL
  end

  def site_email
    SITE_EMAIL
  end

end
