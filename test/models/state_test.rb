require 'test_helper'

class StateTest < ActiveSupport::TestCase
  def test_associations
    cities = City.all
    states(:tamil_nadu).cities.each_with_index do |city, index|
      assert_equal(cities[index], city)
    end

    addresses = Address.all
    states(:tamil_nadu).addresses.each_with_index do |address, index|
      assert_equal(addresses[index], address)
    end
  end

  def test_create
    assert_difference('State.count', 1) do
      State.create({ name: 'Test' })
    end
  end

  def test_update
    state = State.create({ name: 'Test' })
    assert_equal('Test', state.name)
    assert_difference('State.count', 0) do
      state.update_attribute(:name, 'Andhra')
    end
    assert_equal('Andhra', state.reload.name)
  end

  def test_delete
    State.create({ name: 'Test' })
    assert_difference('State.count', -1) do
      State.last.destroy
    end
  end
end
