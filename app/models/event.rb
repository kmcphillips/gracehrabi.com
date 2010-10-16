class Event < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  validates :description, :presence => {:message => "must have a start date"}
  
  def duration
    ends_at - starts_at if ends_at
  end
  
  
end

