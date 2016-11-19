Devise.setup do |config|
  config.email_regexp = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/
end
