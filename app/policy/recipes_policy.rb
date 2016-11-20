class RecipesPolicy
  def self.destroy_record?(user, record)
    check_owner(user, record)
  end

  def self.update_record?(user, record)
    check_owner(user, record)
  end

  def self.add_ingredients_record?(user, record)
    check_owner(user, record)
  end

  def self.add_directions_record?(user, record)
    check_owner(user, record)
  end

  private
  def self.check_owner(user, record)
    user.id == record.user_id
  end
end
