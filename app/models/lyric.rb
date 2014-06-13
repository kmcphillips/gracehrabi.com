class Lyric < ActiveRecord::Base
  validates :title, presence: true

  acts_as_permalink

  scope :sorted, -> { order("title ASC") }
end
