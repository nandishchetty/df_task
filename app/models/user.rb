class User < ApplicationRecord
  acts_as_token_authenticatable

  ROLES = { editor: 'editor', basic: 'basic' }

  has_many :tweets, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :role, presence: true

  def renew_authentication_token
    self.authentication_token = nil
    self.save! # re-generates token
  end

  def is_admin?
  	# if role == 'admin'
      true
    # end
  end
  
end
