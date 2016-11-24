module Admins
  class DashboardController < AdminsController
    before_action :authenticate_admin!

    def index
      @title = 'Dashboard'
    end
  end
end
