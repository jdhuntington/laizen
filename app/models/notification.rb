class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, :polymorphic => true

  validates_presence_of :user
  validates_presence_of :target

  named_scope :unseen, :conditions => { :seen => false }
 
  def summary
    "I am a notification"
  end
  
  def clear
    update_attribute :seen, true
  end

  # This is probably bad
  # Get the commit that the notifiation is ultimately about. If the
  # notification is about a comment, get the commit that the comment
  # is on. Otherwise, just go to the commit. Follows the 'target'
  # method all the way down.
  def root_target(obj=self)
    obj.respond_to?(:target) ? root_target(obj.target) : obj
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  target_id   :integer
#  target_type :string(255)
#  seen        :boolean         default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

