# == Schema Information
#
# Table name: import_field_attributes
#
#  id             :bigint           not null, primary key
#  attributes     :json
#  file_import_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ImportFieldAttribute < ApplicationRecord
end
