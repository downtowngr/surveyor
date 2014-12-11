require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_PROVIDER"] || "redis://localhost:6379" }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_PROVIDER"] || "redis://localhost:6379" }
end
