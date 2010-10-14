class Track < ActiveRecord::Base
  has_attached_file :mp3,
    :url => "/tracks/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/../shared/tracks/:attachment/:id/:style_:basename.:extension"

  validates_attachment_presence :mp3, :message => "file must be selected"
  validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
  validates_attachment_size :mp3, :less_than => 12.megabytes

  validates :title, :presence => true
  validates :sort_order, :numericality => {:greater_than => 0, :message => "is not a valid number"}
  validates :active, :inclusion => [true, false]

  before_validation(:on => :create) do
    self.sort_order = Track.order("sort_order DESC").limit(1).first.try(:sort_order).to_i + 1
  end

end

