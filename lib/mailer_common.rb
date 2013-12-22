module MailerCommon
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods

    def from_email
      '"GraceHrabi.com" <robot@gracehrabi.com>'
    end

  end

  protected

  def site_email
    SITE_EMAIL
  end
end
