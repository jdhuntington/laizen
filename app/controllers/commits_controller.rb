class CommitsController < ApplicationController
  before_filter :load_repository
  def show
    @commit = @repository.commit(params[:id])
  end

  def load_repository
    @repository = Repository.find(params[:repository_id])
  end
end
