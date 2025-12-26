# == Schema Information
#
# Table name: states
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default(TRUE)
#  country_id :bigint
#
class State < ApplicationRecord
  # ---- relationships ----

  has_many :cities
  has_many :addresses
  belongs_to :country

  # ---- scope ----

  scope :search, lambda { |query|
    return all if query.blank?

    where('name ILIKE :q', q: "%#{query}%")
  }

  # ---- additional scopes ----

  scope :valid, -> { where(active: true) }

  # ---- validates ----

  validates :name, presence: true, uniqueness: true
end
