class AdminMailer < ActionMailer::Base
  include MailerCommon

  default from: from_email

  def contact_request(opts)
    subject = "Contact request: #{subject}"

    mail(to: site_email, subject: subject)
  end

  def application_error(message, details={})
    @message = message
    @details = details

    mail(to: admin_email, subject: "Application error for gracehrabi.com")
  end

end
