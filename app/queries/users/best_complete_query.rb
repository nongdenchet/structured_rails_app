module Users
  class BestCompleteQuery
    BEST_LIMIT = 10

    def execute
      User
        .select('users.*, complete_infos.count AS complete_count')
        .joins("LEFT OUTER JOIN (#{complete_infos.to_sql}) AS complete_infos
                ON users.id = complete_infos.user_id")
        .order('complete_count')
        .limit(BEST_LIMIT)
    end

    private
    def complete_infos
      Complete
        .select('user_id, COUNT(completes.id) AS count')
        .group('user_id')
    end
  end
end
