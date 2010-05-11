class Repository < ActiveRecord::Base
  has_many :commits

  def raw_repo
    @repo ||= Grit::Repo.new(path)
  end

  def raw_commits
    raw_repo.commits(branch)
  end

  def raw_commit(sha1)
    raw_repo.commits(sha1,1).first
  end

  def commit(sha1)
    raw_commit(sha1) && commits.find_or_create_by_sha1(raw_commit(sha1).id)
  end

  def remote_update
    `cd "#{path}" && git remote update`
  end

  # TODO this should deterministicly figure out what commits to load.
  # Not just grab 100.
  def iterate_commits
    raw_commits.each do |raw_commit|
      self.commit(raw_commit.sha)
    end
  end
end

# == Schema Information
#
# Table name: repositories
#
#  id         :integer         not null, primary key
#  path       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

