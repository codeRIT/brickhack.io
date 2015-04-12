class MailPreview < MailView
  def application_confirmation_email
    questionnaire = Questionnaire.first
    Mailer.application_confirmation_email(questionnaire)
  end

  def rsvp_confirmation_email
    Mailer.rsvp_confirmation_email(Questionnaire.first.id)
  end

  def accepted_email
    Mailer.accepted_email(Questionnaire.first.id)
  end

  def denied_email
    Mailer.denied_email(Questionnaire.first.id)
  end

  def bulk_message_email
    message = Message.first
    Mailer.bulk_message_email(message, User.first.id)
  end
end if defined?(MailView)
