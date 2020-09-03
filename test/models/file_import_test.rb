require 'test_helper'

class FileImportTest < ActiveSupport::TestCase

  def setup
    file_without_error = File.new(File.join(Rails.root, "/test/files", "usercsv.csv"))
    file_with_error = File.new(File.join(Rails.root, "/test/files", "usercsv-error.csv"))
    @file1 = file_imports(:file1)
    @file1.update_attribute(:data, file_without_error)
    @file2 = file_imports(:file2)
    @file2.update_attribute(:data, file_with_error)
  end

  def test_associations
    assert_equal(users(:john) ,file_imports(:file1).source)
  end

  def test_create
  end

  def test_update
  end

  def test_delete
  end

end
