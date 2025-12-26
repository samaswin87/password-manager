require 'test_helper'

module Users
  class RegistrationsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::ControllerHelpers

    def setup
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    def test_create_with_params
      post(:create, params: { user: { email: 'john@admin.com', password: '1234567890' } })
      assert_nil(request.session['user_return_to'])
    end
  end
end
