class WebhooksController < ApplicationController
  protect_from_forgery except: :create

  def create
    begin
      @webhook = Webhook.create! body: webhook_data if webhook_data
    rescue => e
      ApplicationErrorJob.enqueue("Error processing webhook",
        params: params,
        webhook_data: @webhook_data
      )
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
        ApplicationErrorJob.enqueue("Failed to parse and validate webhook",
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
