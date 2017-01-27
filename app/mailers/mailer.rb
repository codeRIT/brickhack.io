class Mailer < ApplicationMailer
  include Roadie::Rails::Automatic

  default from: '"BrickHack" <noreply@coderit.org>'

  def application_confirmation_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: "Application Received"
    )
  end

  def rsvp_confirmation_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: "RSVP Confirmation"
    )
  end

  def accepted_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: "You've been accepted!"
    )
  end

  def denied_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: "Your application status"
    )
  end

  def bulk_message_email(message_id, user_id)
    @message = Message.find(message_id)
    @user    = User.find(user_id)
    return if @user.blank? || @message.blank?
    mail(
      to: pretty_email(@user.full_name, @user.email),
      subject: @message.subject
    )
  end

  def incomplete_reminder_email(user_id)
    @user = User.find(user_id)
    return if @user.blank? || @user.questionnaire || Time.now.to_date > LAST_DAY_TO_APPLY
    mail(
      to: @user.email,
      subject: "Incomplete Application"
    )
  end

  def bus_captain_confirmation_email(bus_list_id, user_id)
    @user = User.find(user_id)
    @bus_list = BusList.find(bus_list_id)
    return if @user.blank? || @user.questionnaire.blank? || !@user.questionnaire.is_bus_captain? || @bus_list.blank?
    mail(
      to: @user.email,
      subject: "You're a bus captain!"
    )
  end

  private

  def pretty_email(name, email)
    return email if name.blank?
    "\"#{name}\" <#{email}>"
  end
end
