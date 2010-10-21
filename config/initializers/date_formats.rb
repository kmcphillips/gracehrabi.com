Time::DATE_FORMATS[:blog_without_time] = lambda{ |time| time.strftime("%B #{time.day.ordinalize} %Y") }
Time::DATE_FORMATS[:event_with_time] = lambda{ |time| time.strftime("%B #{time.day.ordinalize} %Y at %I:%M%p") }
Time::DATE_FORMATS[:index] = "%b %e/%Y %I:%M%p"

