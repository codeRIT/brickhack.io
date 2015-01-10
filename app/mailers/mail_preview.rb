class MailPreview < MailView
  def application_confirmation_email
    participant = Participant.first
    Mailer.application_confirmation_email(participant)
  end
end if defined?(MailView)
