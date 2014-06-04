class Webhook < ActiveRecord::Base
  has_many :purchases

  validates :body, presence: true
end
