Time.zone = "US/Central"

every :monday do 
  runner "Jobs::MailingListWeeklyEvents.new.process"
end
