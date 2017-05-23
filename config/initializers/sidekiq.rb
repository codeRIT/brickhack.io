if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'] }
  end
end

Sidekiq::Extensions.enable_delay!
