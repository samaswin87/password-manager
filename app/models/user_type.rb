#    Column   |            Type             | Collation | Nullable |                Default
# ------------+-----------------------------+-----------+----------+----------------------------------------
#  id         | bigint                      |           | not null | nextval('user_types_id_seq'::regclass)
#  name       | character varying           |           |          |
#  alias      | character varying           |           |          |
#  created_at | timestamp without time zone |           | not null |
#  updated_at | timestamp without time zone |           | not null |
class UserType < ApplicationRecord
  # ---- relationships ----

  has_many :users

  def self.user
    UserType.find_by(alias: 'user');
  end
end
