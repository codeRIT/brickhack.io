class Mailer < ActionMailer::Base
  default from: "\"codeRIT\" <noreply@coderit.org>"

  def application_confirmation_email(questionnaire_id)
    @questionnaire = Questionnaire.find(questionnaire_id)
    mail(to: pretty_email(@questionnaire.full_name, @questionnaire.user.email), subject: "[BrickHack] Application Received")
  end

  private

  def pretty_email(name, email)
    return email if name.blank?
    "\"#{name}\" <#{email}>"
  end
end
