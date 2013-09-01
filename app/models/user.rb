class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :token_authenticatable, :rememberable, :trackable, :validatable
         # :recoverable, :confirmable, :lockable, :timeoutable

end
