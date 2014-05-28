class Webhook < ActiveRecord::Base
  validates :body, presence: true
end
