class Mailer < ActionMailer::Base
  default from: "\"codeRIT\" <noreply@coderit.org>"

  def application_confirmation_email(registration_id)
    @registration = Registration.find(registration_id)
    mail(to: pretty_email(@registration.full_name, @registration.email), subject: "[BrickHack] Application Received")
  end

  private

  def pretty_email(name, email)
    return email if name.blank?
    "\"#{name}\" <#{email}>"
  end
end
