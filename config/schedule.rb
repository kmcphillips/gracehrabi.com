Time.zone = "US/Central"

every :monday, at: "8am" do 
  runner "Jobs::MailingListWeeklyEvents.new.process"
end
