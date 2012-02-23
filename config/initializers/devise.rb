Devise.setup do |config|

  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.stretches = Rails.env.test? ? 1 : 10
  config.use_salt_as_remember_token = true
  config.reset_password_within = 2.hours
  config.sign_out_via = :delete
  config.mailer_sender = "noreply@diplomatiki.info"
  config.remember_for = 2.weeks
  config.remember_across_browsers = true
  config.password_length = 8..30
  config.email_regexp = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  config.lock_strategy = :failed_attempts
  config.unlock_strategy = :time
  config.maximum_attempts = 20
  config.unlock_in = 1.hour




end
