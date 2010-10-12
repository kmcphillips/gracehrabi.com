class Post < ActiveRecord::Base
  acts_as_permalink

  validates :body, :presence => true
  validates :title, :presence => true, :length => {:maximum => 200}

end

