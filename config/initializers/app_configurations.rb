Rails.application.config.action_mailer.delivery_method = :smtp

Rails.application.config.action_mailer.smtp_settings = {
  address: "smtp.mailgun.org",
  port: 587,
  domain: "mail.trovve.co",
  user_name: "postmaster@mail.trovve.co",
  password: "3bcb860334b775184620d50ca4ed2a8d-156db0f1-abc81c44",
  authentication: "login",
  enable_starttls_auto: false,
}

# sidekiq 的 redis 端口
# if (db_number = ENV['sidekiq_db_number']).present?
#   sidekiq_options = {
#     url: "redis://localhost:6379/#{db_number}"
#   }
#   Sidekiq.configure_server do |config|
#     config.redis = sidekiq_options
#   end
#   Sidekiq.configure_client do |config|
#     config.redis = sidekiq_options
#   end
# end
