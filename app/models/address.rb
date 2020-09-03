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
#  linkable_type      :string
#  linkable_id        :bigint
#  city_id            :bigint
#  state_id           :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
class Address < ApplicationRecord
  # ---- relationships ----
  belongs_to :linkable, polymorphic: true
  belongs_to :city
  belongs_to :state

  # ---- delegates ----

  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :state, prefix: true, allow_nil: true
end
