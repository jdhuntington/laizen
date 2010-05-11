class Commit < ActiveRecord::Base
  has_many :comments, :as => :target
  belongs_to :repository
  
  validates_presence_of :sha1
  validates_presence_of :repository

  after_create :notify_users
  
  def message; raw_commit.message; end
  def committer; raw_commit.committer; end
  def committed_date; raw_commit.committed_date; end
  def diffs; raw_commit.diffs; end

  def summary
    message[0 .. 140]
  end

  def diffs_with_comments
    diffs.map do |diff|
      diff.comments = comments.select { |c| c.path == diff.a_path }
      diff
    end
  end

  def non_line_comments
    comments.reject {|c| c.line_comment? }
  end

  def repository_id
    repository.id
  end

  def to_param
    sha1
  end

  private

  def notify_users
    User.all.each { |u| u.notifications.create!(:target => self) }
  end
  
  def raw_commit
    @raw_commit ||= repository.raw_commit(sha1)
  end
end

# == Schema Information
#
# Table name: commits
#
#  id            :integer         not null, primary key
#  sha1          :string(255)
#  repository_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

