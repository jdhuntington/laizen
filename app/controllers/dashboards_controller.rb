class DashboardsController < ApplicationController
  
  def index
    @notifications_hash = current_user.unseen_grouped_notifications
  end

end
