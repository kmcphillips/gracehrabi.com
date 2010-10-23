class Post < ActiveRecord::Base
  validates :body, :presence => true
  validates :title, :presence => true, :length => {:maximum => 200}

  acts_as_permalink

  has_one :image, :as => :imageable, :dependent => :destroy

  def sort_by; created_at; end
end

