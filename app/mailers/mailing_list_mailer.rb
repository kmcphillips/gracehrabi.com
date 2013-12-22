class MailingListMailer < ActionMailer::Base
  include MailerCommon

  default from: from_email

  def upcoming_events(contact, events)
    @events = events
    @contact = contact

    mail(to: contact.email, subject: "Grace Hrabi: shows for the week of #{Time.now.to_s(:words)}")
  end
  
  private
  
  def mailing_list
    if Rails.env.production?
      Contact.emails
    else
      []
    end
  end

end
