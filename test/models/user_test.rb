require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_validation
  end

  def test_associations
  end

  def test_scopes
  end

  def test_delegates
  end

  def test_alias
  end

  def test_email
  end

  def test_full_name
  end

  def test_invite
  end

  def test_status
    assert_equal('Active', users(:kart).status)
    assert_equal('In Active', users(:jack).status)
  end

  def test_admin?
    assert_true(users(:john).admin?)
    assert_false(users(:kart).admin?)
  end

  def test_member_since
    assert_equal(Time.now.strftime("%b, %Y"),users(:john).member_since)
  end

  def test_create
    assert_difference("User.count", 1) do
      User.create(user_params)
    end
  end

  def test_update
    user = User.create(user_params)
    assert_equal('Test User', user.first_name)
    assert_difference("User.count", 0) do
      user.update_attribute(:first_name, 'Tester')
    end
    assert_equal('Tester', user.reload.first_name)
  end

  def test_delete
    User.create(user_params)
    assert_difference("User.count", -1) do
      User.last.destroy
    end
  end

  def test_attachment
  end

  private

  def user_params
    {
      first_name: 'Test User',
      user_type_id: user_types(:user).id,
      email: 'test@admin.com',
      password: 'password',
      password_confirmation: 'password',
      gender_id: genders(:male).id,
    }
  end
end
