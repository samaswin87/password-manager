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

  # ---- active storage ----
  has_one_attached :attachment

  validate :attachment_content_type

  ALLOWED_CONTENT_TYPES = [
    'application/pdf',
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/gif',
    'application/zip',
    'application/x-zip-compressed',
    'application/x-zip',
    'text/csv',
    'text/plain'
  ].freeze

  private

  def attachment_content_type
    return unless attachment.attached? && !attachment.content_type.in?(ALLOWED_CONTENT_TYPES)

    errors.add(:attachment, 'must be a PDF, image, ZIP, CSV, or text file')
  end
end
