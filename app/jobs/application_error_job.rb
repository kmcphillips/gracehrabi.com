class ApplicationErrorJob < BaseJob
  class << self

    def perform(message, details={})
      Rails.logger.error(message)
      Rails.logger.error(details)

      AdminMailer.application_error(message, details).deliver
    end

  end
end
