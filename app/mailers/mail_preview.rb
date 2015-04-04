class MailPreview < MailView
  def application_confirmation_email
    questionnaire = Questionnaire.first
    Mailer.application_confirmation_email(questionnaire)
  end

  def bulk_message_email
    message = Message.first
    Mailer.bulk_message_email(message, User.first)
  end

  def accepted_email
    Mailer.accepted_email(Questionnaire.first)
  end
end if defined?(MailView)
