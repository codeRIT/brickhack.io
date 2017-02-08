require 'httparty'

class SlackInviteWorker
  include Sidekiq::Worker

  def perform(questionnaire_id)
    questionnaire = Questionnaire.find(questionnaire_id)
    email = questionnaire.email
    first_name = questionnaire.first_name
    last_name = questionnaire.last_name
    response = HTTParty.post("https://brickhack3.slack.com/api/users.admin.invite?email=#{email}&first_name=#{first_name}&last_name=#{last_name}&token=#{ENV['SLACK_API_TOKEN']}&set_active=true")
    json = JSON.parse(response.body, symbolize_names: true)

    raise "Could not read Slack response" unless json

    return if json[:ok]

    if json[:error]
      return if ok_errors.include?(json[:error])
      return if ignore_errors.include?(json[:error])
      raise "Slack error: #{json[:error]}"
    end

    raise "Failed to invite to Slack."
  end

  private

  def ok_errors
    ['already_invited', 'already_in_team']
  end

  def ignore_errors
    ['invalid_email']
  end
end
