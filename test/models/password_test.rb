require 'test_helper'

class PasswordTest < ActiveSupport::TestCase

  def test_validation
  end

  def test_associations
  end

  def test_scopes
  end

  def test_delegates
  end

  def test_status
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
