every :monday do 
  runner "Jobs::MailingListWeeklyEvents.new.process"
end
