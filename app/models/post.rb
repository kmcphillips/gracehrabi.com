class Post < ActiveRecord::Base
  validates :body, :presence => true
  validates :title, :presence => true, :length => {:maximum => 200}

  acts_as_permalink

end

