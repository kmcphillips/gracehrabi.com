class Media < ActiveRecord::Base
  LABELS = ["press_kit"]

  #set_table_name "medias"  ## In the update from 3.0 to 3.0.9 it decided it no longer wanted the plural.

  validates :label, inclusion: LABELS, uniqueness: true

  has_attached_file :file,
    whiny: true,
    path: ":rails_root/public/attachments/media/:class/:id/:style_:basename.:extension",
    url: "/attachments/media/:class/:id/:style_:basename.:extension"

  validates_attachment_size :file, in: 1..10.megabytes
  # validates_attachment_content_type :file, content_type: []

  def to_param
    label
  end

end
