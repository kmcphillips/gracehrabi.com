class ApplicationErrorJob < BaseJob
  class << self

    def perform(message, details={})
      AdminMailer.application_error(message, details).deliver
    end

  end
end
