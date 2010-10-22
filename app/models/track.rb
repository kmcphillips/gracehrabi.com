class Track < ActiveRecord::Base
  has_attached_file :mp3,
    :url => "/assets/:attachment/:id/:basename.:extension",
    :path => ":rails_root/public/assets/:attachment/:id/:basename.:extension"

  validates_attachment_presence :mp3
  validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
  validates_attachment_size :mp3, :less_than => 12.megabytes

  validates :title, :presence => true
  validates :sort_order, :numericality => {:greater_than => 0, :message => "is not a valid number"}
  validates :active, :inclusion => [true, false]

  before_validation(:on => :create) do
    self.sort_order = Track.order("sort_order DESC").limit(1).first.try(:sort_order).to_i + 1
  end

  def self.window_name
    "_#{PAGE_TITLE.downcase.strip.gsub(/[^a-z0-9\w]/, "_")}_player"
  end

  def next
    Track.find_by_sort_order(sort_order + 1) || Track.first
  end

  def previous
    Track.find_by_sort_order(sort_order - 1) || Track.last
  end
end
