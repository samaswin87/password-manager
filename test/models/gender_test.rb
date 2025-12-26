require 'test_helper'

class GenderTest < ActiveSupport::TestCase
  def test_create
    assert_difference('Gender.count', 1) do
      Gender.create(gender_params)
    end
  end

  def test_update
    gender = Gender.create(gender_params)
    assert_equal('Transgender', gender.name)
    assert_difference('Gender.count', 0) do
      gender.update_attribute(:name, 'Test')
    end
    assert_equal('Test', gender.reload.name)
  end

  def test_delete
    Gender.create(gender_params)
    assert_difference('Gender.count', -1) do
      Gender.last.destroy
    end
  end

  private

  def gender_params
    { name: 'Transgender', alias: 'transgender' }
  end
end
