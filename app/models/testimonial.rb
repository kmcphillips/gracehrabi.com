class Testimonial < ActiveRecord::Base
  validates :body, presence: true

  scope :active, -> { where(active: true) }

  class << self

    def random
      order("RAND()").limit(1).first
    end

  end
end
