class Image < ActiveRecord::Base

  GALLERIES = ["a", "b", "c"]

  has_attached_file :file,
    :styles => AttachedImage::SIZES,
    :default_style => :full,
    :whiny => true,
    :path => ":rails_root/public/assets/images/:class/:id/:style_:basename.:extension",
    :url => "/assets/images/:class/:id/:style_:basename.:extension"

  validates_attachment_presence :file
  validates_attachment_size :file, :in => 1..3.megabytes
  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]

  validates :gallery, :inclusion => GALLERIES, :presence => true

  AttachedImage::SIZES.each_key do |key|
    define_method key do
      self.file.url(key)
    end
  end

  GALLERIES.each do |g|
    scope g, order("created_at ASC").where("gallery = ?", g)
  end

  
end
