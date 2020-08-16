#   Column   |            Type             | Collation | Nullable |              Default
# ------------+-----------------------------+-----------+----------+------------------------------------
#  id         | bigint                      |           | not null | nextval('states_id_seq'::regclass)
#  name       | character varying           |           |          |
#  created_at | timestamp without time zone |           | not null |
#  updated_at | timestamp without time zone |           | not null |
class State < ApplicationRecord
  # ---- relationships ----

  has_many :cities
  has_many :addresses

  # ---- scoped search ----

  scoped_search on: [:name]
end
