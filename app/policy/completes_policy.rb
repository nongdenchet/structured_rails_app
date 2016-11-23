class CompletesPolicy
  def self.create_record?(user, recipe)
    user.id != recipe.user_id
  end

  def self.destroy_record?(user, record)
    user.id == record.user_id
  end
end
