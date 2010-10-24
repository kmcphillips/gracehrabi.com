module AttachedImage
  
  SIZES = { :full => "700x560>", :thumb => "120x120#", :inline => "280x280>" }

  def self.included(base)
    base.extend ClassMethods
    base.instance_eval do

      has_attached_file :image,
        :styles => AttachedImage::SIZES,
        :default_style => :full,
        :whiny => true,
        :path => ":rails_root/public/assets/images/:class/:id/:style_:basename.:extension",
        :url => "/assets/images/:class/:id/:style_:basename.:extension"

      validates_attachment_size :image, :in => 1..3.megabytes
      validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]

      validate :setting_valid_image

      attr_accessor :previous_image_id, :clear_image

      AttachedImage::SIZES.each_key do |key|
        define_method key do
          self.image.url(key)
        end
      end

    end
  end

  module ClassMethods
  end

  def setting_valid_image
    errors.add(:image, "is not a valid previous image") if previous_image_id && !self.class.find_by_id(previous_image_id)
  end

end
