class PermissionDenied < BaseError
  def initialize(error = 'Permission denied')
    @error = error
  end

  def code
    'PERMISSION_DENIED'
  end

  def status
    403
  end
end
