class Facebook::Event < Facebook::Base
  include ActiveModel::Model

  attr_reader :event

  def initialize(user_access_token, event)
    @event = event
    @user_access_token = user_access_token
  end

  def save
    begin
      page_graph.put_object('me', 'events', event_params)
    rescue => e
      Rails.logger.error "[Facebook] Failed to publish event."
      Rails.logger.error e
      errors.add(:base, "Failed to publish to facebook: #{ e.message }")
      return false
    end

    event.update_column :published_to_facebook_at, Time.now

    true
  end

  private

  def event_params
    params = {
      name: event.title,
      description: event.description,
      location: "TODO: Location",
      start_time: event.starts_at
    }

    if event.image.exists?
      params[:picture] = Koala::UploadableIO.new(File.open(event.image.path))
    end

    params
  end

end
