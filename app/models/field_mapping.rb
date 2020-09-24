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

  # ---- scopes ----
  scope :password_mapper, -> { where(name: :passwords) }
  scope :user_mapper, -> { where(name: :users) }


  def available_fields
    self.fields&.map {|field| field[0] if field[1]}&.compact
  end

  def field_hash
    field_hash = available_fields.inject({}) do |hash, field|
      hash[field] = I18n.t("#{self.name}.fields.#{field}")
      hash
    end
    field_hash || {}
  end

end
