# == Schema Information
#
# Table name: user_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  alias      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
class UserType < ApplicationRecord
  # ---- relationships ----
  has_many :users

  def self.user
    UserType.find_by(alias: 'user')
  end
end
