require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  should_validate_presence_of :user
  should_validate_presence_of :target
end
