#    Column   |            Type             | Collation | Nullable |              Default
# ------------+-----------------------------+-----------+----------+------------------------------------
#  id         | bigint                      |           | not null | nextval('states_id_seq'::regclass)
#  name       | character varying           |           |          |
#  created_at | timestamp without time zone |           | not null |
#  updated_at | timestamp without time zone |           | not null |
#  active     | boolean                     |           |          | true
class State < ApplicationRecord
  # ---- relationships ----

  has_many :cities
  has_many :addresses

  # ---- scoped search ----

  scoped_search on: [:name]

  # ---- scope ----

  scope :valid, -> { where(active: true) }
end
