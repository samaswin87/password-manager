require 'test_helper'

class FileImportsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def test_index
    sign_in(users(:john))
    get(:index)
    assert_response(:success)
    assert_not_nil assigns(:file_imports)
  end
end
