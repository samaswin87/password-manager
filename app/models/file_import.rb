#       Column       |            Type             | Collation | Nullable |                 Default
# -------------------+-----------------------------+-----------+----------+------------------------------------------
#  id                | bigint                      |           | not null | nextval('file_imports_id_seq'::regclass)
#  state             | character varying           |           |          |
#  data_file_name    | character varying           |           |          |
#  data_content_type | character varying           |           |          |
#  data_file_size    | integer                     |           |          |
#  data_updated_at   | timestamp without time zone |           |          |
#  completed_at      | timestamp without time zone |           |          |
#  source_type       | character varying           |           |          |
#  source_id         | bigint                      |           |          |
#  created_at        | timestamp without time zone |           | not null |
#  updated_at   | timestamp without time zone |           | not null |
class FileImport < ApplicationRecord

  # ---- relationships ----
  belongs_to :source, polymorphic: true

  # ---- paperclip ----
  has_attached_file :data
  validates_attachment_content_type :data, content_type: ['text/csv', 'text/plain']

  # ---- aasm ----
  aasm column: :state do
    state :pending, initial: true
    state :processing, :falied, :completed

    event :parse do
      transitions from: :pending, to: :processing
    end

    event :abort do
      transitions from: [:pending, :processing], to: :falied
    end

    event :end do
      transitions from: [:processing], to: :completed
    end
  end
end
