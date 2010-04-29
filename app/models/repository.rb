class Repository < ActiveRecord::Base
  has_many :commits

  def raw_repo
    @repo ||= Grit::Repo.new(path)
  end

  def raw_commits
    raw_repo.commits
  end

  def raw_commit(sha1)
    raw_repo.commits(sha1).first
  end

  def commit(hash)
    raw_commit = raw_repo.commits(hash).first
    raw_commit && commits.find_or_create_by_sha1(raw_commit.id)
  end
end
