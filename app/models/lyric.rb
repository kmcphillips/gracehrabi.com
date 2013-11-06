class Lyric < ActiveRecord::Base
  validates :title, presence: true

  scope :sorted, -> { order("title ASC") }
end
