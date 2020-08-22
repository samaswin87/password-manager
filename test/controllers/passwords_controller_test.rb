require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_index
    sign_in(users(:john))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:passwords)
  end
end
