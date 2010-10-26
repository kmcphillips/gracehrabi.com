class Image < ActiveRecord::Base

  GALLERIES = {:performance => "Performance", :candid => "Candid", :being_a_butt => "Being a Butt"}.with_indifferent_access

  has_attached_file :file,
    :styles => AttachedImage::SIZES,
    :default_style => :full,
    :whiny => true,
    :path => ":rails_root/public/assets/images/:class/:id/:style_:basename.:extension",
    :url => "/assets/images/:class/:id/:style_:basename.:extension"

  validates_attachment_presence :file
  validates_attachment_size :file, :in => 1..3.megabytes
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]

  validates :gallery, :inclusion => GALLERIES.keys.map(&:to_s)

  scope :all_active, where(:active => true).order("created_at DESC")
  scope :all_inactive, where(:active => false).order("created_at DESC")
  scope :for_gallery, lambda{ |img| where(:gallery => img) }

  AttachedImage::SIZES.each_key do |key|
    define_method key do
      self.file.url(key)
    end
  end

end

