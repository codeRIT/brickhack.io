class Mailer < ActionMailer::Base
  default from: "\"codeRIT\" <noreply@coderit.org>"

  def application_confirmation_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: "[#{subject_base}] Application Received"
    )
  end

  def accepted_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    return unless @questionnaire.present? && @questionnaire.user.present?
    mail(
      to: pretty_email(@questionnaire.full_name, @questionnaire.user.email),
      subject: "[#{subject_base}] You've been accepted!"
    )
  end

  def bulk_message_email(message_id, user_id)
    @message = Message.find(message_id)
    @user    = User.find(user_id)
    return if @user.blank? || @message.blank?
    mail(
      to: pretty_email(@user.full_name, @user.email),
      subject: "[#{subject_base}] #{@message.subject}"
    )
  end

  private

  def subject_base
    "BrickHack"
  end

  def pretty_email(name, email)
    return email if name.blank?
    "\"#{name}\" <#{email}>"
  end
end
