class MailPreview < MailView
  def application_confirmation_email
    questionnaire = Questionnaire.first
    Mailer.application_confirmation_email(questionnaire)
  end
end if defined?(MailView)
