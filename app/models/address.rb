# == Schema Information
#
# Table name: addresses
#
#  id                 :bigint           not null, primary key
#  house_name         :string
#  number             :integer
#  street             :string
#  additional_details :string
#  zipcode            :string
#  city_id            :bigint
#  state_id           :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint
#  country_id         :bigint
#  address_type       :string
#
class Address < ApplicationRecord
  # ---- relationships ----
  belongs_to :user
  belongs_to :country
  belongs_to :state
  belongs_to :city

  # ---- delegates ----

  delegate :name, to: :country, prefix: true
  delegate :name, to: :state, prefix: true
  delegate :name, to: :city, prefix: true

  # ---- enum ----
  enum :address_type, { current: 'current', home: 'home', postal: 'postal' }
end
