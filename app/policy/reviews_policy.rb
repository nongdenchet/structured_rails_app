class ReviewsPolicy
  def self.create?(user, record)
    user.id != record.user_id
  end

  def self.destroy?(user, record)
    user.id == record.user_id
  end
end
