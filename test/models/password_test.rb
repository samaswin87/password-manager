require 'test_helper'

class PasswordTest < ActiveSupport::TestCase

  def test_validation
    passwords(:facebook).url = nil
    assert_false(passwords(:facebook).valid?)
    passwords(:twitter).text_password = nil
    assert_false(passwords(:twitter).valid?)
    passwords(:insta).name = nil
    assert_false(passwords(:insta).valid?)
  end

  def test_associations
    assert_equal(users(:john), passwords(:facebook).user)
  end

  def test_scopes
    assert_equal([passwords(:facebook), passwords(:twitter)], Password.active)
    assert_equal([passwords(:insta)], Password.in_active)
  end

  def test_delegates
    assert_equal('John Daphine', passwords(:facebook).user_name)
  end

  def test_status
    assert_equal('Active', passwords(:facebook).status)
    assert_equal('In Active', passwords(:insta).status)
  end

  def test_create
    assert_difference("Password.count", 1) do
      Password.create(password_params)
    end
  end

  def test_update
    password = Password.create(password_params)
    assert_equal('Password', password.name)
    assert_difference("Password.count", 0) do
      password.update_attribute(:name, 'Test')
    end
    assert_equal('Test', password.reload.name)
  end

  def test_delete
    Password.create(password_params)
    assert_difference("Password.count", -1) do
      Password.last.destroy
    end
  end

  def test_attachment
    facebook = passwords(:facebook)
    image = File.new(File.join(Rails.root, "/test/files", "image.png"))
    facebook.update_attribute(:attachment, image)
    assert_not_nil(facebook.reload.attachment_updated_at)
    assert_equal('image.png', facebook.attachment_file_name)
    assert_equal('image/png', facebook.attachment_content_type)
    assert_equal(16113, facebook.attachment_file_size)
  end

  private

  def password_params
    {
      name: "Password",
      url: "http://test.com",
      username: "test",
      text_password: "test",
      key: "test",
      ssh_private_key: "--key--",
      details: "test",
      user: users(:john),
      ssh_public_key: "--key--"
    }
  end

end
