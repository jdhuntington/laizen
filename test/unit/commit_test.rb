require 'test_helper'

class CommitTest < ActiveSupport::TestCase
  should_have_many :comments
  should_validate_presence_of :sha1
  should_validate_presence_of :repository

  context '#diffs_with_comments' do
    setup do
      @repo = Factory(:repository)
      @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
      @c1 = @commit.comments.create!(:user => Factory(:email_confirmed_user))
      @c2 = @commit.comments.create!(:user => Factory(:email_confirmed_user), :path => 'a')
      @c3 = @commit.comments.create!(:user => Factory(:email_confirmed_user), :path => 'dir-a/file-a')
      @c4 = @commit.comments.create!(:user => Factory(:email_confirmed_user), :path => 'dir-a/file-a')
    end

    should 'return comments with the diffs' do
      assert_equal [@c2], @commit.diffs_with_comments.first.comments
      assert_equal [@c3, @c4], @commit.diffs_with_comments.last.comments
    end
  end
end
