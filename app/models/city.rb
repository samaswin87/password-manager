#    Column   |            Type             | Collation | Nullable |              Default
# ------------+-----------------------------+-----------+----------+------------------------------------
#  id         | bigint                      |           | not null | nextval('cities_id_seq'::regclass)
#  name       | character varying           |           |          |
#  state_id   | bigint                      |           |          |
#  created_at | timestamp without time zone |           | not null |
#  updated_at | timestamp without time zone |           | not null |
#  active     | boolean                     |           |          | true
class City < ApplicationRecord
  # ---- relationships ----

  belongs_to :state
  has_many :addresses

  # ---- scoped search ----

  scoped_search on: [:name]
end
