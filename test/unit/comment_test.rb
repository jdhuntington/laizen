require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CommentTest < ActiveSupport::TestCase
  should_validate_presence_of :user
  should_validate_presence_of :target

  context 'notification' do
    setup do
      @repo = Factory(:repository)
      @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
      @user1 = Factory(:email_confirmed_user)
      @user2 = Factory(:email_confirmed_user)
      @user3 = Factory(:email_confirmed_user)
    end

    should 'create notifications for all other users when a new comment is created' do
      assert @user1.notifications.empty?
      assert @user2.notifications.empty?
      assert @user3.notifications.empty?

      Comment.create!(:target => @commit, :user => @user3)
      
      @user1.reload
      @user2.reload
      @user3.reload
      assert_equal 1, @user1.notifications.length
      assert_equal 1, @user2.notifications.length
      assert @user3.notifications.empty?
    end
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

