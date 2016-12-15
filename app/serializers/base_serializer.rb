class BaseSerializer < ActiveModel::Serializer
  class << self
    attr_accessor :include

    def default_include(value)
      self.include = value
    end
  end

  def default_include_tree
    self.class.include || '*'
  end

  def as_json(adapter_opts = {})
    if default_include_tree
      super(include: adapter_opts.merge!(include: default_include_tree))
    end
    super
  end
end
