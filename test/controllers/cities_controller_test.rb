require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_index_with_admin
    sign_in(users(:john))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:cities)
  end

  def test_index_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:index)
    end
  end

  def test_show_with_admin
    sign_in(users(:john))
    get(:show,  params: {id: cities(:chennai).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:city)
  end

  def test_show_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:show,  params: {id: cities(:chennai).id, user_id: users(:kart).id})
    end
  end

  def test_new_with_admin
    sign_in(users(:john))
    get(:new)
    assert_response(:success)
    assert_not_nil assigns(:city)
  end

  def test_new_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:new)
    end
  end

  def test_create_with_admin
    sign_in(users(:john))
    post(:create, params: city_params)
    assert_redirected_to(city_path(City.last))
  end

  def test_create_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      post(:create, params: city_params)
    end
  end

  def test_edit_with_admin
    sign_in(users(:john))
    get(:edit,  params: {id: cities(:chennai).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:city)
  end

  def test_edit_with_user
    sign_in(users(:kart))
    assert_raise CanCan::AccessDenied do
      get(:edit,  params: {id: cities(:chennai).id, user_id: users(:kart).id})
    end
  end

  private

  def city_params
    { city: {
      name: 'Test City',
      state_id: states(:tamil_nadu).id,
    }}
  end
end
