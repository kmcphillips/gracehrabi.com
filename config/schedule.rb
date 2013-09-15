Time.zone = "US/Central"

every :monday, at: "1am" do
  rake "jobs:deliver_weekly_mailer"
end
