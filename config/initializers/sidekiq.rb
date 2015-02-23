if Rails.env.production? || Rails.env.staging?
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://:#{ENV['REDIS_PASSWORD']}@#{ENV['OPENSHIFT_REDIS_HOST']}:#{ENV['OPENSHIFT_REDIS_PORT']}" }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://:#{ENV['REDIS_PASSWORD']}@#{ENV['OPENSHIFT_REDIS_HOST']}:#{ENV['OPENSHIFT_REDIS_PORT']}" }
  end
end
