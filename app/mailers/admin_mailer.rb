class AdminMailer < ActionMailer::Base
  include MailerCommon

  default from: from_email

  def contact_request(opts)
    subject = "Contact request: #{subject}"

    mail(to: site_email, subject: subject)
  end

end
