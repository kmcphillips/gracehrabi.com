class Purchase < ActiveRecord::Base
  belongs_to :webhook
  belongs_to :download

  has_many :download_records

  validates :download_id, presence: true
  validates :token, presence: true
  validates :email, presence: true

  before_validation :set_token

  after_create :send_email

  delegate :shopify_product_id, :filename, to: :download

  def record_download(request)
    new_record = download_records.build(
      download: download,
      token: token,
      ip_address: request.env["REMOTE_ADDR"],
      useragent: request.env["HTTP_USER_AGENT"]
    )

    unless new_record.save
      ApplicationErrorJob.enqueue("Could not create download record",
        purchase: self,
        download: download,
        request: request
      )
    end

    new_record
  end

  private

  def send_email
    PurchaseCreateNotificationJob.enqueue(id)
  end

  def set_token
    self.token = SecureRandom.hex(8) if self.token.blank?
  end
end
