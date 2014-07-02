class Webhook < ActiveRecord::Base
  has_many :purchases

  affairs_of_state :pending, :processing, :success, :failure

  validates :body, presence: true

  def parse
    if pending? && persisted?
      processing!

      begin
        process_order_creation if customer_email

        if accepts_marketing? && customer_email.present?
          contact = Contact.build_from_email(customer_email)
          contact.source = "shopify"
          contact.save!
        end

        success!
      rescue => e
        log_webhook_error("Failed to process webhook", e)
        failure!
      end
    end

    success?
  end

  def as_hash
    begin
      @as_hash ||= JSON.parse(body)
    rescue => e
      log_webhook_error("Failed to parse JSON webhook.", e)
      nil
    end
  end

  def accepts_marketing?
    !!as_hash['buyer_accepts_marketing']
  end

  private

  def process_order_creation
    as_hash["line_items"].each do |line_item|
      if download = Download.find_by(shopify_product_id: line_item["product_id"])
        purchase = download.purchases.build(
          webhook: self,
          email: customer_email,
          name: customer_name,
          address: customer_address
        )

        purchase.save!

        PurchaseCreateNotificationJob.enqueue(purchase.id)
      end
    end
  end

  def customer_email
    as_hash["customer"]["email"]
  end

  def customer_address
    address = as_hash["shipping_address"]
    return "" unless address

    [
      "#{ address["first_name"] } #{ address["last_name"] }",
      address["address1"],
      address["address2"],
      "#{ address["city"] }, #{ address["province"] }",
      address["country_name"],
      address["zip"]
    ].reject(&:blank?).join("\n")
  end

  def customer_name
    [as_hash["customer"]["first_name"], as_hash["customer"]["last_name"]].join(" ")
  end

  def log_webhook_error(message, error, extras={})
    ApplicationErrorJob.enqueue(message, {
        error: error.inspect,
        backtrace: error.backtrace.join("\n"),
        body: body,
        webhook_id: id,
        status: status,
        created_at: created_at
      }.merge(extras)
    )
  end
end
