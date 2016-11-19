class Validator
  include ActiveModel::Model

  def validate!
    raise ValidateError.new(errors.full_messages) unless valid?
  end
end
