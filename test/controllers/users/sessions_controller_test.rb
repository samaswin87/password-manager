require 'test_helper'

module Users
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::ControllerHelpers

    def setup
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    def test_new
      get(:new)
      assert_response(:success)
      assert_template 'devise/sessions/new'
    end

    def test_create
      post(:create)
      assert_response(:success)
      assert_template 'devise/sessions/new'
    end

    def test_create_with_params
      post(:create, params: { user: { email: 'john@admin.com', password: '1234567890' } })
      assert_nil(request.session['user_return_to'])
    end

    def test_create_with_inactive_user
      post(:create, params: { user: { email: 'jack@user.com', password: '23232323io' } })
      delete(:destroy)
      assert_equal('User is in in active. Please contact admin', flash[:alert])
      assert_nil(request.session['user_return_to'])
    end
  end
end
