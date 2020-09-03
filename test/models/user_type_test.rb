require 'test_helper'

class UserTypeTest < ActiveSupport::TestCase

  def test_associations
    assert_equal(users(:john), user_types(:admin).users.first)
  end

  def test_create
    assert_difference("UserType.count", 1) do
      UserType.create(user_type_params)
    end
  end

  def test_update
    user_type = UserType.create(user_type_params)
    assert_equal('Test', user_type.name)
    assert_difference("UserType.count", 0) do
      user_type.update_attribute(:name, 'Tester')
    end
    assert_equal('Tester', user_type.reload.name)
  end

  def test_delete
    UserType.create(user_type_params)
    assert_difference("UserType.count", -1) do
      UserType.last.destroy
    end
  end

  def test_user
    assert_equal(user_types(:user), UserType.user)
  end

  private

  def user_type_params
    {name: 'Test', alias: 'test'}
  end
end
