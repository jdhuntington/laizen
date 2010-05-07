require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CommentsControllerTest < ActionController::TestCase
  context 'controller' do
    context '#create' do
      should 'create a line comment on the commit' do
        @repo = Factory(:repository)
        @commit = @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7'
        @controller.current_user = Factory(:email_confirmed_user)
        post :create, {"comment"=>{"line"=>"193-192", "path"=>"app/models/user.rb", "content"=>"blah"}, "commit_id"=>"ee11b903c0b041a550a757e8cb1c3513034ca5f7", "authenticity_token"=>"0vi9FNAkblbw1Sf0ULC6mukDKD4XvSrjhHSzt/6ynD4=", "repository_id"=>@repo.id}
        assert @commit.reload.comments.first.line_comment?
      end
    end
  end
end
