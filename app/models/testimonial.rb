class Testimonial < ActiveRecord::Base
  validates :body, presence: true

  scope :active, -> { where(active: true) }
end
