class WebhooksController < ApplicationController
  protect_from_forgery except: :create

  def create
    if webhook_data
      @webhook = Webhook.new body: webhook_data

      unless @webhook.save
        Rails.logger.error("Failed to save webhook! #{ @webhook.errors.full_messages }") 
        AdminMailer.application_error("Failed to save webhook! #{ @webhook.errors.full_messages }",
          params: params,
          request_data: request_data
        )
      end
    end

    head(:ok)
  end

  private

  def webhook_data
    @webhook_data ||= begin
      request.body.rewind
      request_data = request.body.read
      digest  = OpenSSL::Digest.new('sha256')
      calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, Settings.shopify.shared_secret, request_data)).strip

      if calculated_hmac == request.env["HTTP_X_SHOPIFY_HMAC_SHA256"]
        request_data
      else
        Rails.logger.error("Failed to parse and validate webhook!")
        Rails.logger.error("  params: #{ params }")
        Rails.logger.error("  request_data: #{ request_data }")
        Rails.logger.error("  HTTP_X_SHOPIFY_HMAC_SHA256: #{ request.env["HTTP_X_SHOPIFY_HMAC_SHA256"] }")

        AdminMailer.application_error("Failed to parse and validate webhook",
          params: params,
          request_data: request_data,
          shopify_hmac: request.env["HTTP_X_SHOPIFY_HMAC_SHA256"],
          expected_hmac: calculated_hmac
        )

        nil
      end
    end
  end
end
