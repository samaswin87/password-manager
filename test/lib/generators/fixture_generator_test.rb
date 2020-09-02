require 'test_helper'
require 'generators/fixture/fixture_generator'

class FixtureGeneratorTest < Rails::Generators::TestCase
  tests FixtureGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator ["arguments"]
    end
  end
end
