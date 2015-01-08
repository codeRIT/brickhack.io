class Mailer < ActionMailer::Base
  default from: "\"codeRIT\" <noreply@coderit.org>"

  def application_confirmation_email(participant_id)
    @participant = Participant.find(participant_id)
    mail(to: pretty_email(@participant.full_name, @participant.email), subject: "[BrickHack] Application Received")
  end

  private

  def pretty_email(name, email)
    return email if name.blank?
    "\"#{name}\" <#{email}>"
  end
end
