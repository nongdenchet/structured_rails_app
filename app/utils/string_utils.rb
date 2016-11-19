class StringUtils
  def self.underscore(value)
    word = value.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr!('-', '_')
    word.downcase!
    word
  end

  def self.capitalize_first(value)
    value.slice(0,1).capitalize + value.slice(1..-1)
  end
end
