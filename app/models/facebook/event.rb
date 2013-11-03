class Facebook::Event < Facebook::Base
  include ActiveModel::Model

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def save
    begin
      
    rescue => e
      Rails.logger.error "[Facebook] Failed to publish event."
      Rails.logger.error e
      errors.add(:base, "Failed to publish to facebook: #{ e.message }")
      return false
    end

    event.update_column :published_to_facebook_at, Time.now

    true
  end

end
