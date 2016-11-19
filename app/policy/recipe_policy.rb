class RecipePolicy
  def self.destroy?(user, record)
    user.id == record.user_id
  end
end
