class RecipePolicy
  def self.destroy?(user, record)
    check_owner(user, record)
  end

  def self.update?(user, record)
    check_owner(user, record)
  end

  private
  def self.check_owner(user, record)
    user.id == record.user_id
  end
end
