require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class NotificationTest < ActiveSupport::TestCase
  context '#clear' do
    setup do
      @repo = Factory(:repository)
      @user1 = Factory(:email_confirmed_user)
    end

    should 'mark itself seen' do
      @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
      assert_equal 1, Notification.unseen.length
      Notification.first.clear
      assert_equal 0, Notification.unseen.length
    end
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

