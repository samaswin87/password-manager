require 'test_helper'

class PasswordAttachmentTest < ActiveSupport::TestCase

  def setup
    @file = File.new(File.join(Rails.root, "/test/files", "user.csv"))
    @file1 = File.new(File.join(Rails.root, "/test/files", "user-error.csv"))
  end

  def test_associations
    assert_equal(passwords(:john_facebook), password_attachments(:attachment_1).password)
  end


end
