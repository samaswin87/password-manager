require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @file = fixture_file_upload(File.join(Rails.root, "/test/files", "user.csv"))
  end

  def test_index_with_user
    sign_in(users(:kart))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:passwords)
  end

  def test_show_with_admin
    sign_in(users(:john))
    get(:show,  params: {id: passwords(:john_facebook).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:password)
  end

  def test_show_with_user
    sign_in(users(:kart))
    get(:show,  params: {id: passwords(:kart_facebook).id, user_id: users(:kart).id})
    assert_response(:success)
    assert_not_nil assigns(:password)
  end

  def test_new_with_admin
    sign_in(users(:john))
    get(:new)
    assert_response(:success)
    assert_not_nil assigns(:password)
  end

  def test_new_with_user
    sign_in(users(:kart))
    get(:new)
    assert_response(:success)
    assert_not_nil assigns(:password)
  end

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

  def test_create_with_admin
    sign_in(users(:john))
    post(:create, params: password_params)
    assert_redirected_to(password_path(Password.last))
  end

  def test_create_with_user
    sign_in(users(:kart))
    params = password_params
    params[:user_id] = users(:kart).id
    post(:create, params: password_params)
    assert_redirected_to(password_path(Password.last))
  end

  def test_edit_with_admin
    sign_in(users(:john))
    get(:edit,  params: {id: passwords(:john_facebook).id, user_id: users(:john).id})
    assert_response(:success)
    assert_not_nil assigns(:password)
  end

  def test_edit_with_user
    sign_in(users(:kart))
    get(:edit,  params: {id: passwords(:kart_facebook).id, user_id: users(:kart).id})
    assert_response(:success)
    assert_not_nil assigns(:password)
  end

  def test_status_with_admin
    sign_in(users(:john))
    facebook = passwords(:kart_facebook)
    assert_true(facebook.active)
    put(:status, params: {id: passwords(:kart_facebook).id, user_id: users(:john).id})
    assert_response(:success)
    assert_false(facebook.reload.active)
  end

  def test_status_with_user
    sign_in(users(:kart))
    facebook = passwords(:kart_facebook)
    assert_true(facebook.active)
    put(:status, params: {id: passwords(:kart_facebook).id, user_id: users(:kart).id})
    assert_response(:success)
    assert_false(facebook.reload.active)
  end

  def test_uploads
    sign_in(users(:john))
    assert_difference "PasswordAttachment.count", 1 do
      put(:uploads, params: {id: passwords(:john_facebook).id, attachments: [@file]})
    end
    body = JSON.parse(response.body)
    assert_equal('Success', body["status"])
  end

  def test_attachment
    sign_in(users(:john))
    assert_difference "PasswordAttachment.count", -1 do
      delete(:attachment, params: {id: passwords(:john_facebook).id, attachment_id: 1})
    end
    assert_redirected_to(action: "show")
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
