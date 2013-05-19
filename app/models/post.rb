class Post < ActiveRecord::Base
  validates :body, :presence => true
  validates :title, :presence => true, :length => {:maximum => 200}

  acts_as_permalink

  include AttachedImage

  scope :recent, order("created_at DESC").limit(3)

  def sort_by; created_at; end
end

