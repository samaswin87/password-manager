# == Schema Information
#
# Table name: password_attachments
#
#  id                      :bigint           not null, primary key
#  attachment_file_name    :string
#  attachment_content_type :string
#  attachment_file_size    :bigint
#  attachment_updated_at   :datetime
#  password_id             :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class PasswordAttachment < ApplicationRecord

  # ---- relationships ----
  belongs_to :password

  # ---- paperclip ----
  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => ['application/pdf', /\Aimage\/.*\z/, "application/zip", "application/x-zip"]
end
