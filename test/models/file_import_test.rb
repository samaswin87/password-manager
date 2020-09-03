require 'test_helper'

class FileImportTest < ActiveSupport::TestCase

  def setup
    @file_without_error = File.new(File.join(Rails.root, "/test/files", "usercsv.csv"))
    @file_with_error = File.new(File.join(Rails.root, "/test/files", "usercsv-error.csv"))
  end

  def test_associations
    assert_equal(users(:john) ,file_imports(:file1).source)
  end

  def test_create
    assert_difference("FileImport.count", 1) do
      FileImport.create(file_params)
    end
  end

  def test_update
    import = FileImport.create(file_params)
    assert_equal(462, import.data_file_size)
    assert_difference("FileImport.count", 0) do
      import.update_attribute(:data, @file_without_error)
    end
    assert_equal(379, import.data_file_size)
  end

  def test_delete
    assert_difference("FileImport.count", -1) do
      FileImport.last.destroy
    end
  end

  private

  def file_params
    {
      data: @file_with_error,
      source: users(:john)
    }
  end
end
