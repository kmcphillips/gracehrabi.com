class Purchase < ActiveRecord::Base
  belongs_to :webhook
  belongs_to :download

  validates :webhook_id, presence: true
  validates :download_id, presence: true
  validates :token, presence: true

  before_validation :set_token

  delegate :shopify_product_id, :filename, to: :download

  private

  def set_token
    self.token = SecureRandom.hex(8) if self.token.blank?
  end
end
