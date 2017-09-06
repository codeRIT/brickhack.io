SparkPostRails.configure do |c|
  c.api_key = ENV['SPARKPOST_API_KEY']
  c.track_opens = true
  c.track_clicks = true
  c.campaign_id = 'BrickHack 4'
  c.html_content_only: true
end
