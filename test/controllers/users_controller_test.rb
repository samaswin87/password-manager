require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_index_with_admin
    sign_in(users(:john))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:users)
  end

  def test_index_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:index)
    end
  end

  def test_show_with_admin
    sign_in(users(:john))
    get(:show,  params: {id: users(:john).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:user)

    get(:show,  params: {id: users(:kart).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:user)
  end

  def test_show_with_user
    sign_in(users(:kart))
    get(:show,  params: {id: users(:kart).id, user_id: users(:kart).id})
    assert_response(:success)
    assert_not_nil assigns(:user)
  end

  def test_new_with_admin
    sign_in(users(:john))
    get(:new)
    assert_response(:success)
    assert_not_nil assigns(:user)
  end

  def test_new_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:new)
    end
  end

  def test_create_with_admin
    sign_in(users(:john))
    assert_mails(1) do
      post(:create, params: user_params)
    end
    assert_redirected_to(user_path(User.last))
  end

  def test_create_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      post(:create, params: user_params)
    end
  end

  def test_edit_with_admin
    sign_in(users(:john))
    get(:edit,  params: {id: users(:john).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:user)

    get(:edit,  params: {id: users(:kart).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:user)
  end

  def test_edit_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:edit,  params: {id: users(:kart).id, user_id: users(:kart).id})
    end
  end

  def test_status_with_admin
    sign_in(users(:john))
    kart = users(:kart)
    assert_true(kart.active)
    put(:status, params: {id: users(:kart).id, user_id: users(:john).id})
    assert_response(:success)
    assert_false(kart.reload.active)
  end

  def test_status_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      put(:status, params: {id: users(:kart).id, user_id: users(:john).id})
    end
  end

  private

  def user_params
    {user: {
      first_name: 'Test User',
      user_type_id: user_types(:user).id,
      email: 'test@admin.com',
      password: 'password',
      password_confirmation: 'password',
      gender_id: genders(:male).id,
    }}
  end

end
