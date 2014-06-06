class Webhook < ActiveRecord::Base
  has_many :purchases

  affairs_of_state :pending, :processing, :success, :failure

  validates :body, presence: true

  def parse
    if pending?
      processing!

      begin
        raise "pending"

        success!
      rescue => e
        log_webhook_error("Failed to process webhook", e)
        failure!
      end
    end
  end

  def as_hash
    begin
      @as_hash ||= JSON.parse(body)
    rescue => e
      log_webhook_error("Failed to parse JSON webhook.", e)
      nil
    end
  end

  private

  def log_webhook_error(message, error, extras={})
    ApplicationErrorJob.enqueue(message, {
        error: error,
        body: body,
        webhook_id: id,
        status: status,
        created_at: created_at
      }.merge(extras)
    )
  end
end
