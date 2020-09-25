# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  state_id   :bigint
#  city_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Country < ApplicationRecord
end
