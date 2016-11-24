class RecipesPolicy
  def self.destroy?(user, record)
    check_owner(user, record)
  end

  def self.update?(user, record)
    check_owner(user, record)
  end

  def self.add_ingredients?(user, record)
    check_owner(user, record)
  end

  def self.add_directions?(user, record)
    check_owner(user, record)
  end

  def self.show?(_, record)
    record.status >= Recipes::Status::DONE
  end

  private
  def self.check_owner(user, record)
    user.id == record.user_id
  end
end
