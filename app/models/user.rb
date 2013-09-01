class User < ActiveRecord::Base
  devise :token_authenticatable, :rememberable, :trackable, :omniauthable, :database_authenticatable, :validatable, omniauth_providers: [:google]
  # :recoverable, :confirmable, :lockable, :timeoutable, :database_authenticatable

  validates :email, presence: true

  def authorized?
    !!AuthorizedEmail.where(email: email).first
  end

  class << self

    def find_for_open_id(access_token, signed_in_resource=nil)
      User.where(email: access_token.info["email"]).first_or_create
    end

  end
end
