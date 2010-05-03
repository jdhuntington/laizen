require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class NotificationTest < ActiveSupport::TestCase
  context '#clear' do
    setup do
      @repo = Factory(:repository)
      @user1 = Factory(:email_confirmed_user)
    end

    should 'destroy itself' do
      @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
      assert_equal 1, Notification.all.length
      Notification.first.clear
      assert_equal 0, Notification.all.length
    end

    should 'clear all notifications dependent on the target' do
      @user2 = Factory(:email_confirmed_user)
      @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
      commit_notification = @user2.notifications.first
      Comment.create!(:target => @commit, :user => @user1)
      @user2.reload
      comment_notification = (@user2.notifications - [comment_notification]).first
      commit_notification.clear
      @user2.reload
      assert_equal 0, @user2.notifications.length
    end
  end
end
