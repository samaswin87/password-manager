#      Column     |            Type             | Collation | Nullable |                 Default
# ----------------+-----------------------------+-----------+----------+------------------------------------------
#  id             | bigint                      |           | not null | nextval('job_statuses_id_seq'::regclass)
#  job_id         | character varying           |           |          |
#  error_messages | text                        |           |          |
#  percentage     | integer                     |           |          | 0
#  created_at     | timestamp without time zone |           | not null |
#  updated_at     | timestamp without time zone |           | not null |
class JobStatus < ApplicationRecord

  # ---- relationships ----
  has_many :file_imports, dependent: :delete_all

  # ---- validates ----
  validates :percentage, length: {minimum: 0, maximum: 100}, allow_blank: false

end
