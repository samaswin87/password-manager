class UserType < ActiveRecord::Base
  # ---- relationships ----

  has_many :users
end
