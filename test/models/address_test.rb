require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  def test_associations
  end

  def test_delegates
  end

  def test_create
    assert_difference("Address.count", 1) do
      Address.create(address_params)
    end
  end

  def test_update
    address = Address.create(address_params)
    assert_equal('test-name', address.house_name)
    assert_difference("Address.count", 0) do
      address.update_attribute(:house_name, 'Test')
    end
    assert_equal('Test', address.reload.house_name)
  end

  def test_delete
    Address.create(address_params)
    assert_difference("Address.count", -1) do
      Address.last.destroy
    end
  end

  private

  def address_params
    {
      house_name: 'test-name',
      number: 90,
      street: 'test-street',
      additional_details: 'test-details',
      zipcode: '90990900',
      linkable_type: 'User',
      linkable: users(:john),
      city: cities(:chennai),
      state: states(:tamil_nadu),
    }
  end

end
