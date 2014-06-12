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
    Settings.site_email
  end

  def admin_email
    Settings.admin_email
  end
end
