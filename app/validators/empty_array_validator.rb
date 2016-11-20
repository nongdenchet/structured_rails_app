class EmptyArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank?
      add_error(record, attribute)
    else
      value.each do |element|
        add_error(record, attribute) if element.blank?
      end
    end
  end

  private
  def add_error(record, attribute)
    record.errors[attribute] << (options[:message] || 'can\'t be blank')
  end
end
