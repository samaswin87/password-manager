# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  alias      :string           not null
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Country < ApplicationRecord
  # ---- relationships ----
  has_many :states
  has_many :cities

  # ---- scope ----

  scope :valid, -> { where(active: true) }
end
