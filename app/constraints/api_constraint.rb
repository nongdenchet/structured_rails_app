class ApiConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version).to_s
  end

  def matches?(request)
    request
      .headers
      .fetch(:accept)
      .include?("version=#{version}")
  end
end
