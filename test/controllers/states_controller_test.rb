require 'test_helper'

class StatesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_index_with_admin
    sign_in(users(:john))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:states)
  end

  def test_index_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:index)
    end
  end

  def test_show_with_admin
    sign_in(users(:john))
    get(:show,  params: {id: states(:tamil_nadu).id, user_id: users(:john).id}, xhr: true)
    assert_response(:success)
    assert_not_nil assigns(:state)
  end

  def test_show_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:show,  params: {id: states(:tamil_nadu).id, user_id: users(:kart).id})
    end
  end

  def test_new_with_admin
    sign_in(users(:john))
    get(:new)
    assert_response(:success)
    assert_not_nil assigns(:state)
  end

  def test_new_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:new)
    end
  end

  def test_create_with_admin
    sign_in(users(:john))
    post(:create, params: state_params)
    assert_redirected_to(state_path(State.last))
  end

  def test_create_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      post(:create, params: state_params)
    end
  end

  def test_edit_with_admin
    sign_in(users(:john))
    get(:edit,  params: {id: states(:tamil_nadu).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:state)
  end

  def test_edit_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:edit,  params: {id: states(:tamil_nadu).id, user_id: users(:kart).id})
    end
  end

  private

  def state_params
    {
      state: {
        name: 'Test state',
      }
    }
  end
end
