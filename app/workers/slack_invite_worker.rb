require 'httparty'

class SlackInviteWorker
  include Sidekiq::Worker

  def perform(questionnaire_id)
    questionnaire = Questionnaire.find(questionnaire_id)
    email = questionnaire.email
    first_name = questionnaire.first_name
    last_name = questionnaire.last_name
    json = query_api('users.admin.invite', "&email=#{email}&first_name=#{first_name}&last_name=#{last_name}&set_active=true")

    return if json[:ok]

    if json[:error]
      return if ok_errors.include?(json[:error])
      return attempt_manual_invite(questionnaire.id, email) if use_manual_errors.include?(json[:error])
      raise "Slack error: #{json[:error]}"
    end

    raise "Failed to invite to Slack."
  end

  private

  def query_api(method, params = '')
    response = HTTParty.post("https://brickhack3.slack.com/api/#{method}?token=#{ENV['SLACK_API_TOKEN']}#{params}")
    json = JSON.parse(response.body, symbolize_names: true)
    raise "Could not read Slack response" unless json
    json
  end

  def attempt_manual_invite(questionnaire_id, email)
    json = query_api('users.list')
    raise "Slack error: #{json[:error]}" if json[:error]

    return if json[:members].find { |member| member[:profile][:email] == email }

    Mailer.delay.slack_invite_email(questionnaire_id)
  end

  def ok_errors
    ['already_invited', 'already_in_team']
  end

  def use_manual_errors
    ['invalid_email', 'invite_limit_reached']
  end
end
