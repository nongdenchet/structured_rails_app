class Validator
  include ActiveModel::Model

  def validate!
    raise ValidateError.new(errors.full_messages) unless valid?
  end

  def self.require_params(params)
    raise NotImplementedError
  end

  def self.init(params)
    new(require_params(params))
  end
end
