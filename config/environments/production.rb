Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.log_level = :info
  config.serve_static_files = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.action_dispatch.show_exceptions = false

  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { host: 'twill-mystore.herokuapp.com'}
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address:              ENV['MAILGUN_SMTP_SERVER'],
  #   port:                 ENV['MAILGUN_SMTP_PORT'],
  #   domain:               'twill-mystore.herokuapp.com',
  #   user_name:            ENV['MAILGUN_SMTP_LOGIN'],
  #   password:             ENV['MAILGUN_SMTP_PASSWORD'],
  #   authentication:       'plain',
  #   enable_starttls_auto: true  }

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'localhost:3000'}
  config.action_mailer.delivery_method = :letter_opener
end
