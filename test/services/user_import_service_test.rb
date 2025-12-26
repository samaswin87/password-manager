require 'test_helper'

class UserImportServiceTest < ActiveSupport::TestCase
  def setup
    file_without_error = File.new(Rails.root.join('/test/files', 'user.csv'))
    file_with_error = File.new(Rails.root.join('/test/files', 'user-error.csv'))
    @file1 = file_imports(:file1)
    @file1.update_attribute(:data, file_without_error)
    @file2 = file_imports(:file2)
    @file2.update_attribute(:data, file_with_error)
  end

  def test_file_import
    service = UserImportService.new(@file1.id, field_maps)
    assert_count(3, User.count)
    assert_equal('pending', @file1.state)
    assert_nil(@file1.completed_at)
    assert_difference('User.count', 10) do
      service.call
    end
    assert_count(13, User.count)

    assert_equal('completed', @file1.reload.state)
    assert_count(0, @file1.failed_count)
    assert_count(10, @file1.total_count)
    assert_count(10, @file1.parsed_count)
    assert_count(10, @file1.success_count)
    assert_not_nil(@file1.completed_at)
  end

  def test_file_import_with_errors
    service = UserImportService.new(@file2.id, field_maps)
    assert_count(3, User.count)
    assert_nil(@file2.completed_at)
    assert_difference('User.count', 10) do
      service.call
    end
    assert_count(13, User.count)
    assert_equal('completed', @file2.reload.state)
    assert_count(3, @file2.failed_count)
    assert_count(13, @file2.total_count)
    assert_count(10, @file2.parsed_count)
    assert_count(10, @file2.success_count)
    assert_not_nil(@file2.completed_at)
  end

  private

  def field_maps
    {
      first_name: 'first',
      last_name: 'last',
      gender: 'gender',
      email: 'email'
    }
  end
end
