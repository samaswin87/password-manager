require 'test_helper'

class CityTest < ActiveSupport::TestCase
  def test_associations
    assert_equal(states(:tamil_nadu), cities(:chennai).state)
    assert_equal(addresses(:john), cities(:chennai).addresses.first)
  end

  def test_create
    assert_difference('City.count', 1) do
      City.create(city_param)
    end
  end

  def test_update
    city = City.create(city_param)
    assert_equal('Test', city.name)
    assert_difference('City.count', 0) do
      city.update_attribute(:name, 'Trichy')
    end
    assert_equal('Trichy', city.reload.name)
  end

  def test_delete
    City.create(city_param)
    assert_difference('City.count', -1) do
      City.last.destroy
    end
  end

  private

  def city_param
    {
      name: 'Test',
      state: states(:tamil_nadu)
    }
  end
end
