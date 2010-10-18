class Event < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true
  validates :starts_at, :presence => {:message => "must have a start date"}

  scope :upcoming, lambda { where("events.starts_at > ?", Time.now) }
  scope :current, lambda { t = Time.now; where("events.ends_at IS NOT NULL AND events.starts_at < ? AND events.ends_at > ?", t, t) }
  scope :past, lambda { t = Time.now; where("(events.ends_at IS NOT NULL && events.ends_at < ?) OR (events.ends_at IS NULL && events.starts_at < ?)", t, t) }

  def sort_by; starts_at; end

  def duration
    ends_at - starts_at if ends_at
  end

  def status
    t = Time.now
    if starts_at > t
      "Upcoming"
    elsif ends_at && starts_at < t && ends_at > t
      "Current"
    elsif (ends_at && ends_at < t) || (!ends_at && starts_at < t)
      "Past"
    end
  end
end

