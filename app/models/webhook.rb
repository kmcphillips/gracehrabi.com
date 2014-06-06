class Webhook < ActiveRecord::Base
  has_many :purchases

  affairs_of_state :pending, :processing, :success, :failure

  validates :body, presence: true

  def as_hash
    begin
      @as_hash ||= JSON.parse(body)
    rescue => e
      ApplicationErrorJob.enqueue("Failed to parse JSON webhook.",
        body: body,
        error: e,
        webhook_id: id
      )

      nil
    end
  end
end
