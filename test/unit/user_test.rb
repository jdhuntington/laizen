require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class UserTest < ActiveSupport::TestCase
  context '#clear_notifications_on_commit' do
    setup do
      @repo = Factory(:repository)
      @user1 = Factory(:email_confirmed_user)
      @user2 = Factory(:email_confirmed_user)
      @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
    end

    should 'clear all notifications dependent on the commit' do
      Comment.create!(:target => @commit, :user => @user1)
      @user2.reload
      assert_equal 2, @user2.notifications.unseen.length
      @user2.clear_notifications_on_commit @commit
      @user2.reload
      assert_equal 0, @user2.notifications.unseen.length
    end
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

