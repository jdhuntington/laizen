class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, :polymorphic => true

  validates_presence_of :user
  validates_presence_of :target

  named_scope :unseen, :conditions => { :seen => false }
  
  def clear
    udpate_attribute :seen, true
  end
end
