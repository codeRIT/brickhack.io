class Mailer < ActionMailer::Base
  default from: '"codeRIT" <noreply@coderit.org>'

  def application_confirmation_email(participant_id)
    @participant = Participant.find(participant_id)
    mail(to: @participant.email, subject: "[BrickHack] Application Received")
  end
end
