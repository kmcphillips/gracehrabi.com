class Facebook::Event < Facebook::Base
  include ActiveModel::Model

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def save
    
  end

end
