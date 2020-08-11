class State < ActiveRecord::Base
  # ---- relationships ----

  has_many :cities
  has_many :addresses

  # ---- scoped search ----

  scoped_search on: [:name]
end
