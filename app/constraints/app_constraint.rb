class AppConstraint
  def matches?(request)
    !request.url.include?('/api') && !request.url.include?('/admins')
  end
end
