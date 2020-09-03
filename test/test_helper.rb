ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_mails(count)
    ActionMailer::Base.deliveries.clear
    assert_difference('ActionMailer::Base.deliveries.size', count) do
      yield
    end
  end

  def assert_true(act, msg = nil)
    assert_equal(true, act, msg)
  end

  def assert_false(act, msg = nil)
    assert_equal(false, act, msg)
  end

  def assert_count(exp_count, act_count, msg = nil)
    assert_equal(exp_count, act_count, msg)
  end

end
