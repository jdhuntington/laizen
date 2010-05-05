require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RepositoryTest < ActiveSupport::TestCase

  context 'commits' do
    setup do
      @repo = Factory(:repository)
    end

    should 'create a commit record if one is looked up and found' do
      assert @repo.commits.empty?
      @repo.commit 'ee11b903c0b041a550a757e8cb1c3513034ca5f7' # the third
      @repo.reload
      assert !@repo.commits.empty?
    end

    should 'not create a commit record if one is looked up and not found' do
      assert @repo.commits.empty?
      @repo.commit '0000ee11b903c0b041a550a757e8cb1c3513034c'
      @repo.reload
      assert @repo.commits.empty?
    end
  end
end

# == Schema Information
#
# Table name: repositories
#
#  id         :integer         not null, primary key
#  path       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

