#         Column          |            Type             | Collation | Nullable |                Default
# -------------------------+-----------------------------+-----------+----------+---------------------------------------
#  id                      | bigint                      |           | not null | nextval('passwords_id_seq'::regclass)
#  name                    | character varying           |           |          |
#  url                     | character varying           |           |          |
#  username                | character varying           |           |          |
#  password                | character varying           |           |          |
#  key                     | character varying           |           |          |
#  ssh                     | text                        |           |          |
#  details                 | text                        |           |          |
#  attachment_file_name    | character varying           |           |          |
#  attachment_content_type | character varying           |           |          |
#  attachment_file_size    | integer                     |           |          |
#  attachment_updated_at   | timestamp without time zone |           |          |
#  user_id                 | bigint                      |           |          |
#  created_at              | timestamp without time zone |           | not null |
#  updated_at              | timestamp without time zone |           | not null |
class Password < ApplicationRecord
  # ---- relationships ----
  belongs_to :user

  # ---- delegates ----
  delegate :name, to: :user, prefix: true, allow_nil: false

  # ---- paperclip ----
  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => ["application/zip", "application/x-zip"]

  before_post_process :skip_for_zip

  def skip_for_zip
     ! %w(application/zip application/x-zip).include?(attachment_content_type)
  end
end
