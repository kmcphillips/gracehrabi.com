class AdminMailer < ActionMailer::Base
  default from: ROBOT_EMAIL

  include MailerCommon

  def contact_request(opts)
    subject = "Contact request: #{subject}"

    mail(to: site_email, subject: subject)
  end

  def application_error(message, details={})
    @message = message
    @details = details

    mail(to: admin_email, subject: "GraceHrabi.com error")
  end

end
