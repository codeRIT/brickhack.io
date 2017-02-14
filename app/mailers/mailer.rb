class Mailer < ApplicationMailer
  include Roadie::Rails::Automatic
  add_template_helper(ApplicationHelper)

  default from: '"BrickHack" <noreply@coderit.org>'

  def application_confirmation_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail_questionnaire("Application Received")
  end

  def rsvp_confirmation_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail_questionnaire("RSVP Confirmation")
  end

  def accepted_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail_questionnaire("You've been accepted!")
  end

  def denied_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail_questionnaire("Your application status")
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
    return if @user.blank? || @user.questionnaire || Time.now.to_date > Rails.configuration.hackathon['last_day_to_apply']
    mail(
      to: @user.email,
      subject: "Incomplete Application"
    )
  end

  def bus_captain_confirmation_email(bus_list_id, user_id)
    @user = User.find(user_id)
    @questionnaire = @user.questionnaire
    @bus_list = BusList.find(bus_list_id)
    return if @user.blank? || @user.questionnaire.blank? || !@user.questionnaire.is_bus_captain? || @bus_list.blank?
    mail_questionnaire("You're a bus captain!")
  end

  def slack_invite_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return if @questionnaire.blank?
    mail_questionnaire("Slack Invite!")
  end

  def bus_list_update_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    @bus_list = @questionnaire.bus_list
    return if @questionnaire.blank? || @questionnaire.user.blank? || @bus_list.blank?
    mail_questionnaire("Bus Update")
  end

  private

  def pretty_email(name, email)
    return email if name.blank?
    "\"#{name}\" <#{email}>"
  end

  def mail_questionnaire(subject)
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: subject
    )
  end
end
