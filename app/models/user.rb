class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :admin_limited_access

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
end
