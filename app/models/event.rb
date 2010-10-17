class Event < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  validates :starts_at, :presence => {:message => "must have a start date"}

  scope :upcoming, lambda { where("events.starts_at > ?", Time.zone.now) }
  scope :current, lambda { t = Time.now; where("events.ends_at IS NOT NULL AND events.starts_at < ? AND events.ends_at > ?", t, t) }
  scope :past, lambda { t = Time.now; where("(events.ends_at IS NOT NULL && events.ends_at < ?) OR (events.ends_at IS NULL && events.starts_at < ?)", t, t) }  

  def duration
    ends_at - starts_at if ends_at
  end
  
  def sort_by; starts_at; end
end

