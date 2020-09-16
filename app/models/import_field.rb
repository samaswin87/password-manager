# == Schema Information
#
# Table name: import_fields
#
#  id             :bigint           not null, primary key
#  file_import_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ImportField < ApplicationRecord
end
