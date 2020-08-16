#        Column       |            Type             | Collation | Nullable |                Default
# --------------------+-----------------------------+-----------+----------+---------------------------------------
#  id                 | bigint                      |           | not null | nextval('addresses_id_seq'::regclass)
#  house_name         | character varying           |           |          |
#  number             | integer                     |           |          |
#  street             | character varying           |           |          |
#  additional_details | character varying           |           |          |
#  zipcode            | character varying           |           |          |
#  linkable_type      | character varying           |           |          |
#  linkable_id        | bigint                      |           |          |
#  city_id            | bigint                      |           |          |
#  state_id           | bigint                      |           |          |
#  created_at         | timestamp without time zone |           | not null |
#  updated_at         | timestamp without time zone |           | not null |
class Address < ApplicationRecord
  # ---- relationships ----
  belongs_to :linkable, polymorphic: true
  belongs_to :city
  belongs_to :state

  # ---- delegates ----

  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :state, prefix: true, allow_nil: true
end
