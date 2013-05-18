class MailingListMailer < ActionMailer::Base
  default from: ROBOT_EMAIL

  include MailerCommon

  def upcoming_events(contact, events)
    @events = events
    @contact = contact

    mail(to: contact.email, subject: "Grace Hrabi: performances for the week of #{Time.now.to_s(:words)}")
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
