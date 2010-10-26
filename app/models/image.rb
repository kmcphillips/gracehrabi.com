class Image < ActiveRecord::Base

  GALLERIES = {:performance => "Performance", :candid => "Candid", :being_a_butt => "Being a Butt"}.with_indifferent_access

  has_attached_file :file,
    :styles => AttachedImage::SIZES,
    :default_style => :full,
    :whiny => true,
    :path => ":rails_root/public/assets/images/:class/:id/:style_:basename.:extension",
    :url => "/assets/images/:class/:id/:style_:basename.:extension"

  validates_attachment_presence :file
  validates_attachment_size :file, :in => 1..5.megabytes
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]
  validates :sort_order, :uniqueness => {:scope => :gallery}, :presence => true
  validates :gallery, :inclusion => GALLERIES.keys.map(&:to_s)

  before_validation :set_sort_order, :on => :create

  scope :all_active, where(:active => true).order("created_at DESC")
  scope :all_inactive, where(:active => false).order("created_at DESC")
  scope :for_gallery, lambda{ |img| where(:gallery => img) }
  scope :in_order, order("sort_order ASC")

  AttachedImage::SIZES.each_key do |key|
    define_method key do
      self.file.url(key)
    end
  end

  protected
  
  def set_sort_order
    self.sort_order = (Image.for_gallery(self.gallery).order("sort_order DESC").limit(1).first.try(:sort_order) || 0) + 1
  end
end

