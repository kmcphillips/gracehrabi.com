class Contact < ActiveRecord::Base

  validates :email, :email_format => true

  scope :active, :conditions => {:disabled => false}

  ## class methods

  def self.emails
    active.map(&:email).uniq.compact
  end

  def self.last_updated_at
    order("updated_at DESC").first.try(:updated_at)
  end

end
