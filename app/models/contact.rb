class Contact < ActiveRecord::Base

  validates :email, email_format: true, uniqueness: true

  before_save :set_token, on: :create

  scope :active, -> { where(disabled: false) }
  scope :sorted, -> { order("disabled ASC, created_at DESC") }
  scope :partial_search, ->(search) { where("email LIKE ?", "%#{ search }%") }

  def enabled
    !disabled
  end
  alias_method :enabled?, :enabled

  def disable
    update_attribute(:disabled, true)
  end

  def enable
    update_attribute(:disabled, false)
  end

  class << self

    def build_from_email(email)
      contact = find_by_email(email) || Contact.new(email: email)
      contact.disabled = false
      contact
    end

    def emails
      active.map(&:email).uniq.reject(&:blank?)
    end

    def last_updated_at
      order("updated_at DESC").first.try(:updated_at)
    end

    def add_bulk(emails)
      count = 0

      emails.split(/[ \t\r\n,]/).uniq.each do |email|
        contact = Contact.find_by_email(email) || Contact.new(email: email)
        contact.disabled = false
        contact.source = "bulk"

        count = count + 1 if contact.save
      end

      count
    end
  end

  private

  def set_token
    self.token = SecureRandom.hex(16) unless self.token
    true
  end

end

