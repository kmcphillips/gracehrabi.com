class MailingListMailer < ActionMailer::Base
  default from: ROBOT_EMAIL

  include MailerCommon

  def upcoming_events
    subject = "TODO"
    @events = Event.for_mailing_list

    mail(:to => "grace@gracehrabi.com", bcc: mailing_list, subject: subject)
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
