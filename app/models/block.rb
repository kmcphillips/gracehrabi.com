class Block < ActiveRecord::Base
  validates :body, :presence => true
  validates :label, :presence => true
  validates :path, :presence => true


end

