class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:mlh]

  has_one :questionnaire

  def active_for_authentication?
    true
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def queue_reminder_email
    return if reminder_sent_at
    Mailer.delay_for(1.day).incomplete_reminder_email(id)
    update_attribute(:reminder_sent_at, Time.now)
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
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid               = auth.uid
      user.email             = auth.info.email
      user.password          = Devise.friendly_token[0, 20]
    end
  end

  def self.without_questionnaire
    User.left_outer_joins(:questionnaire).where(questionnaires: { id: nil }, admin: false)
  end
end
