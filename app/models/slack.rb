require 'httparty'
SLACK_TOKEN = ENV['SLACK_API_TOKEN']
CHANNEL = "CEVDW26C8".freeze
SLACK_METHOD = "https://slack.com/api/channels.history".freeze
COUNT = 20

class Slack
  def initialize(sheet = 0)
    if !response || response["ok"] == false
      Rails.logger.error "Error reading Slack. Response: #{response['error'].inspect}"
      return
    end
    @sheet = response["messages"].map { |message| message["text"] }
  end

  def response
    # There's two levels of caching going on here.
    # 1. "@response ||=" which caches in memory for subsequent calls to response() within the same Slack instance / web request
    # 2. "Rails.cache" which caches between requests (up until expiry)
    @response ||= Rails.cache.fetch(cache_key, expires_in: 1.minute) do
      response = HTTParty.get("#{SLACK_METHOD}?token=#{SLACK_TOKEN}&channel=#{CHANNEL}&count=#{COUNT}")
      # to_hash is used here to guarantee Rails/Redis can cache it properly
      response ? response.parsed_response.to_hash : nil
    end
  end

  def cache_key
    "slack/#{CHANNEL}"
  end
end
