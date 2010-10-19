Time::DATE_FORMATS[:blog_without_time] = lambda{ |time| time.strftime("%B #{time.day.ordinalize} %Y") }

