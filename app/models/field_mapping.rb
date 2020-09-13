# == Schema Information
#
# Table name: field_mappings
#
#  id         :bigint           not null, primary key
#  fields     :json
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FieldMapping < ApplicationRecord

  # ---- validates ----
  validates :name, presence: true, uniqueness: true

  def available_fields
    self.fields.map {|field| field[0] if field[1]}.compact
  end

end
