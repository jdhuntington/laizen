require 'digest/md5'

class User < ActiveRecord::Base

  has_many :comments
  has_many :notifications
  
  include Clearance::User

  def name
    email.split('@').first
  end


  def gravatar(size=:default)
    self.class.gravatar(email, size)
  end
  
  def self.gravatar(email, size=:default)
    size_lookup = { :default => 45, :small => 25 }
    "http://www.gravatar.com/avatar/#{md5(email)}?s=#{size_lookup[size]}"
  end

  def self.md5(txt)
    Digest::MD5.hexdigest txt
  end

  def clear_notifications_on_commit(commit)
    notifications.select { |notification| notification.root_target == commit }.each(&:clear)
    true
  end

  def unseen_grouped_notifications
    notifications.unseen.group_by &:root_target
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  email_confirmed    :boolean         default(FALSE), not null
#  created_at         :datetime
#  updated_at         :datetime
#

