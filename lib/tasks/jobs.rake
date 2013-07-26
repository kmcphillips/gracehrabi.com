namespace :jobs do

  desc "Send the weekly mailing list"
  task deliver_weekly_mailer: :environment do
    MailingListWeeklyEventsJob.new.process
  end

end
