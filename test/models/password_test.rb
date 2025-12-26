require 'test_helper'

class PasswordTest < ActiveSupport::TestCase
  def test_validation
    passwords(:john_facebook).url = nil
    assert_false(passwords(:john_facebook).valid?)
    passwords(:john_twitter).text_password = nil
    assert_false(passwords(:john_twitter).valid?)
    passwords(:john_insta).name = nil
    assert_false(passwords(:john_insta).valid?)
  end

  def test_associations
    assert_equal(users(:john), passwords(:john_facebook).user)
    assert_equal([password_attachments(:attachment_1)], passwords(:john_facebook).attachments)
  end

  def test_scopes
    assert_equal(
      [passwords(:john_facebook), passwords(:john_twitter), passwords(:kart_facebook),
       passwords(:kart_twitter)], Password.active
    )
    assert_equal([passwords(:john_insta), passwords(:kart_insta)], Password.in_active)
  end

  def test_delegates
    assert_equal('John Daphine', passwords(:john_facebook).user_name)
  end

  def test_status
    assert_equal('Active', passwords(:john_facebook).status)
    assert_equal('In Active', passwords(:john_insta).status)
  end

  def test_create
    assert_difference('Password.count', 1) do
      Password.create(password_params)
    end
  end

  def test_update
    password = Password.create(password_params)
    assert_equal('Password', password.name)
    assert_difference('Password.count', 0) do
      password.update_attribute(:name, 'Test')
    end
    assert_equal('Test', password.reload.name)
  end

  def test_delete
    Password.create(password_params)
    assert_difference('Password.count', -1) do
      Password.last.destroy
    end
  end

  private

  def password_params
    {
      name: 'Password',
      url: 'http://test.com',
      username: 'test',
      text_password: 'test',
      key: 'test',
      ssh_private_key: '--key--',
      details: 'test',
      user: users(:john),
      ssh_public_key: '--key--'
    }
  end
end
