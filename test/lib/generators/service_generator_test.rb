require 'test_helper'
require 'generators/service/service_generator'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_generator_runs_without_errors
    assert_nothing_raised do
      run_generator ['user']
    end
  end

  def test_generates_stub_correctly
    run_generator ['user']

    assert_file 'app/services/user_service.rb' do |service|
      assert service.include? 'UserService < ApplicationService'
    end

    assert_file 'test/services/user_service_test.rb' do |test|
      assert test.include? 'UserServiceTest'
    end
  end
end
