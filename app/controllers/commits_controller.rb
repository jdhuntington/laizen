class CommitsController < ApplicationController
  before_filter :load_repository
  def show
    @commit = @repository.commit(params[:id])
    current_user.clear_notifications_on_commit(@commit)
  end

  def load_repository
    @repository = Repository.find(params[:repository_id])
  end
end
