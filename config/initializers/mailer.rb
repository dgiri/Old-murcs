ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => "-i -t -f #{AppConfig.support_email}"
}
ActionMailer::Base.default_url_options[:host] = AppConfig.host

