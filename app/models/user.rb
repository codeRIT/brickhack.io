class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async, 
         :omniauthable, :omniauth_providers => [:github]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider
  attr_accessible :admin_read_only

  has_one :questionnaire

  def active_for_authentication?
    true
  end

  def email=(value)
    super value.try(:downcase)
  end

  def first_name
    return "" if questionnaire.blank?
    questionnaire.first_name
  end

  def last_name
    return "" if questionnaire.blank?
    questionnaire.last_name
  end

  def full_name
    return "" if questionnaire.blank?
    questionnaire.full_name
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, email: auth.info.email).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.password_confirmation = user.password
    end
  end  
end
