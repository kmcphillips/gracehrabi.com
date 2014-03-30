class Post < ActiveRecord::Base
  validates :body, presence: true
  validates :title, presence: true, length: {maximum: 200}

  acts_as_permalink

  include AttachedImage

  scope :recent, -> { sorted.limit(3) }
  scope :sorted, -> { order("created_at DESC") }

  def sort_by
    created_at
  end

end
