class User < ActiveRecord::Base
  devise :token_authenticatable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:google]
  # :recoverable, :confirmable, :lockable, :timeoutable, :database_authenticatable

  validates :email, presence: true

  def authorized?
    !!AuthorizedEmail.where(email: email).first
  end

  class << self

    def find_for_open_id(access_token, signed_in_resource=nil)
      User.where(email: access_token.info["email"]).first || User.create!(email: access_token.info["email"], password: Devise.friendly_token[0,20])
    end

  end
end
