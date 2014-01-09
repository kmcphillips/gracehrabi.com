class Testimonial < ActiveRecord::Base
  validates :body, presence: true
end
