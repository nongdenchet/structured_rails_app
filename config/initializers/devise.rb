Devise.setup do |config|
  config.email_regexp = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/
  config.mailer.class_eval do
    helper :subdomain
  end
end
