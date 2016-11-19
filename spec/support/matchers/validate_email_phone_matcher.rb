module Matchers
  module ValidatePhoneFormatMatcher
    RSpec::Matchers.define :validate_phone_format_of do |attribute|
      match do |model|
        result = true

        valid_phones = %w(0988144155 +86335112345)
        invalid_phones = %w(1928a372 ninja_assassin)

        valid_phones.each do |valid_phone|
          model.send("#{attribute}=", valid_phone)
          model.valid?
          result &&= !(model.errors.keys.include? attribute)
        end

        invalid_phones.each do |invalid_phone|
          model.send("#{attribute}=", invalid_phone)
          model.valid?
          result &&= model.errors.keys.include? attribute
        end

        result
      end

      description do
        "has valid phone format of #{attribute}"
      end
    end
  end
end
