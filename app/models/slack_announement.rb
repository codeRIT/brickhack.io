require 'httparty'
SLACK_TOKEN = ENV['SLACK_TOKEN']
CHANNEL = "CEVDW26C8".freeze
SLACK_METHOD = "https://slack.com/api/channels.history".freeze
COUNT = 20

class Slack
  def initialize
    if !response || response["ok"] == false
      Rails.logger.error "Error reading Slack. Response: #{response['error'].inspect}"
      return
    end
    @sheet = response["messages"].map(&:text)
  end

  def response
    response = HTTParty.get("#{SLACK_METHOD}?token=#{SLACK_TOKEN}&channel=#{CHANNEL}&count=#{COUNT}")
    response ? response.parsed_response.to_hash : nil
  end
end
