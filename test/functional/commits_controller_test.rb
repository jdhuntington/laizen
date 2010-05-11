require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CommitsControllerTest < ActionController::TestCase
  context 'controller' do
    context '#show' do
      should 'clear all notifications' do
        @repo = Factory(:repository)
        @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
        @controller.current_user = Factory(:email_confirmed_user)
        @controller.current_user.expects(:clear_notifications_on_commit).with(@commit)
        get :show, :repository_id => @commit.repository_id, :id => @commit.sha1
      end
    end
  end
end
