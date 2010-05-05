class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, :polymorphic => true

  validates_presence_of :user
  validates_presence_of :target

  after_create :notify_users
  
  def render_for(x,y)
    raise [x,y].inspect
  end

  def last_line_number
    line
  end

  def first_line_number
    line
  end

  def render_for(*args)
    "I am a comment!!!"
  end

  def line_comment?
    !!(line && path)
  end

  def commit_id
    target.sha1
  end

  def repository_id
    target.repository_id
  end

  private

  def notify_users
    (User.all - [user]).each { |u| u.notifications.create!(:target => self) }
  end
  
end

# == Schema Information
#
# Table name: comments
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  content     :text
#  path        :string(255)
#  line        :string(255)
#  target_id   :integer
#  target_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

