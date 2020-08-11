class City < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :state
  has_many :addresses

  # ---- scoped search ----

  scoped_search on: [:name]
end
