class MailPreview < MailView
  def application_confirmation_email
    registration = Registration.first
    Mailer.application_confirmation_email(registration)
  end
end if defined?(MailView)
