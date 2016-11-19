module Matchers
  module ValidateEmailFormatMatcher
    RSpec::Matchers.define :validate_email_format_of do |attribute|
      match do |model|
        result = true

        valid_emails = %w(test@test.com com+1@gmail.com)
        invalid_emails = %w(test@gmail,com com-1)

        valid_emails.each do |valid_email|
          model.send("#{attribute}=", valid_email)
          model.valid?
          result &&= !(model.errors.keys.include? attribute)
        end

        invalid_emails.each do |invalid_email|
          model.send("#{attribute}=", invalid_email)
          model.valid?
          result &&= model.errors.keys.include? attribute
        end

        result
      end

      description do
        "has valid email format of #{attribute}"
      end
    end
  end
end
