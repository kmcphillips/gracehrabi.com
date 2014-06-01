class ApplicationErrorJob < BaseJob
  class << self

    def process(message, details={})
      AdminMailer.application_error(message, details).deliver
    end

  end
end
