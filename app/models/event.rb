class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :starts_at, presence: {message: "must have a start date"}

  include AttachedImage

  scope :upcoming, lambda { t = Time.now; where("events.starts_at > ?", t.end_of_day).order("starts_at ASC") }
  scope :current,  lambda { t = Time.now; where("events.starts_at BETWEEN ? AND ?", t.beginning_of_day, t.end_of_day).order("starts_at DESC") }
  scope :past,     lambda { t = Time.now; where("events.starts_at < ?", t.beginning_of_day).order("starts_at DESC") }
  scope :publicized, where(publicized: true)
  scope :for_mailing_list, lambda{ |distance=2.weeks|
    t = Time.now.beginning_of_day
    publicized.where("events.starts_at BETWEEN ? AND ?", t, t + distance).order("starts_at ASC")
  }
  scope :on_date, lambda{|date| where("starts_at BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)}

  def sort_by; starts_at; end

  def status
    if upcoming?
      "Upcoming"
    elsif current?
      "Current"
    elsif past?
      "Past"
    end
  end

  def upcoming?
    starts_at > Time.now.end_of_day
  end

  def current?
    (Time.now.beginning_of_day..Time.now.end_of_day).cover? starts_at
  end

  def past?
    starts_at < Time.now.beginning_of_day
  end

  def clone
    c = super
    if image.exists?
      ["image_file_name", "image_content_type", "image_file_size", "image_updated_at", "image_fingerprint"].each{|a| c.send("#{a}=", nil)}
      c.previous_image_id = id
    end
    c
  end

  def export_body
    "<p><strong>#{ title }</strong></p><p>#{ description }</p>"
  end

  def manitoba_music_id
    2880
  end

  def manitoba_music_exported
    update_attribute :manitoba_music_exported_at, Time.now
  end

end

