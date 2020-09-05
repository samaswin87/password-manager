require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_index
    sign_in(users(:john))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:passwords)
  end

  def test_create_with_error
    sign_in(users(:john))
    params = password_params
    params[:password][:url] = nil
    post(:create, params: params)
    assert_equal('Url cannot be blank', flash[:alert])
    assert_template :new
  end

  private

  def password_params
    {password: {
      name: "Password",
      url: "http://test.com",
      username: "test",
      text_password: "test",
      key: "test",
      ssh_private_key: "--key--",
      details: "test",
      user_id: users(:john).id,
      ssh_public_key: "--key--"
    }}
  end

end
