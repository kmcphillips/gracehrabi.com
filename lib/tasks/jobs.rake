namespace :jobs do

  desc "Send email with upcoming gigs"
  task events_mailer: :environment do
    MailingListMailer.upcoming_events.deliver
  end
  
end
