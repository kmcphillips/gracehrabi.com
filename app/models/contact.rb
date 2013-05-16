class Contact < ActiveRecord::Base

  validates :email, email_format: true

  before_save :set_token, on: :create

  scope :active, conditions: {disabled: false}
  
  def enabled
    !disabled
  end
  
  def disable
    update_attribute(:disabled, true)
  end
  
  def enable
    update_attribute(:disabled, false)
  end
  
  class << self
    
    def emails
      active.map(&:email).uniq.reject(&:blank?)
    end

    def last_updated_at
      order("updated_at DESC").first.try(:updated_at)
    end
    
  end

  private
  
  def set_token
    self.token = SecureRandom.hex(16) unless self.token
    true  
  end
  
end

