class ForeignKeyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      options[:class_name].find(value)
    rescue ActiveRecord::RecordNotFound => _
      add_error(record, attribute)
    end
  end

  private
  def add_error(record, attribute)
    record.errors[attribute] << (options[:message] || 'record not found')
  end
end
