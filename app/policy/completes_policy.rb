class CompletesPolicy
  def self.create?(user, recipe)
    user.id != recipe.user_id
  end

  def self.destroy?(user, record)
    user.id == record.user_id
  end
end
