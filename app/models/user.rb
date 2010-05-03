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

end
