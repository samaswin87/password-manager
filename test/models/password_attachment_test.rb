require 'test_helper'

class PasswordAttachmentTest < ActiveSupport::TestCase
  def setup
    @file = File.new(Rails.root.join('/test/files', 'user.csv'))
  end

  def test_associations
    assert_equal(passwords(:john_facebook), password_attachments(:attachment_1).password)
  end

  def test_create
    assert_difference('PasswordAttachment.count', 1) do
      PasswordAttachment.create(attachment_params)
    end
  end

  def test_destroy
    assert_difference('PasswordAttachment.count', -1) do
      PasswordAttachment.last.destroy
    end
  end

  private

  def attachment_params
    {
      attachment: @file,
      password: passwords(:john_facebook)
    }
  end
end
