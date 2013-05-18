module Jobs
  class MailingListWeeklyEvents
    
    def initialize
      @contacts = Contact.active
      @events = Event.for_mailing_list(2.weeks)
      
      log "Initialized with #{ @contacts.size } contacts and #{ @events.size } events"
    end
    
    def process
      if @events.any?
        log "Sending #{ @events.size } events"
        
        @contacts.each do |contact|
          log "delivering to #{ contact.inspect }"
          begin
            MailingListMailer.upcoming_events(contact, @events).deliver
          rescue => e
            Rails.logger.error("Jobs::MailingListWeeklyEvents -- Error delivering to #{ contact }: #{ e.message }")
          end
        end
      else
        log "No events to send"
      end
    end
    
    private
    
    def log(message)
      Rails.logger.info("Jobs::MailingListWeeklyEvents -- #{ message }")
    end
    
  end
end
