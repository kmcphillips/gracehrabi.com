class Block < ActiveRecord::Base
  validates :label, :presence => true
  validates :path, :presence => true


end
