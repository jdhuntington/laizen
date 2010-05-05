class CommentsController < ApplicationController
  before_filter :load_repository
  before_filter :load_commit
  
  def create
    @comment = @commit.comments.create!(params[:comment].merge({:user => current_user}))
    respond_to do |format|
      format.html { render :partial => 'comments/non_line_comment', :locals => { :comment => @comment } }
      format.json { render :json    => @comment.to_json }
    end
  end

  def load_repository
    @repository = Repository.find(params[:repository_id])
  end

  def load_commit
    @commit = @repository.commit(params[:id])
  end
end
