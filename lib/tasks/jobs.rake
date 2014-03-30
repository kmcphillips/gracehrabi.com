namespace :jobs do

  desc "Send the weekly mailing list"
  task deliver_weekly_mailer: :environment do
    MailingListWeeklyEventsJob.new.perform
  end

end
