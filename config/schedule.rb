Time.zone = "US/Central"

every :monday, at: "8am" do
  rake "jobs:deliver_weekly_mailer"
end
