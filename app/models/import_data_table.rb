# == Schema Information
#
# Table name: import_data_tables
#
#  id             :bigint           not null, primary key
#  columns        :jsonb            not null
#  file_import_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class ImportDataTable < ApplicationRecord
  # ---- serialize ----
  serialize :columns, HashSerializer

  # ---- relationships ----
  belongs_to :file_import, polymorphic: true
end
