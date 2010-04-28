class Repository < ActiveRecord::Base
  include Grit

  def repo
    @repo ||= Repo.new(path)
  end

  def commits
    repo.commits
  end

  def commit(hash)
    repo.commits(hash).first
  end
end
