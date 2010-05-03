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

  private

  def notify_users
    (User.all - [user]).each { |u| u.notifications.create!(:target => self) }
  end
  
end
