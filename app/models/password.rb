# == Schema Information
#
# Table name: passwords
#
#  id                  :bigint           not null, primary key
#  name                :string
#  url                 :string
#  username            :string
#  text_password       :string
#  key                 :string
#  ssh_private_key     :text
#  details             :text
#  user_id             :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  active              :boolean          default(TRUE)
#  ssh_public_key      :text
#  ssh_finger_print    :string
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :bigint
#  logo_updated_at     :datetime
#  password_changed_at :datetime
#  password_copied_at  :datetime
#  password_viwed_at   :datetime
#  email               :string
#
class Password < ApplicationRecord
  # ---- relationships ----
  belongs_to :user
  has_many :attachments, dependent: :delete_all, class_name: 'PasswordAttachment'

  # ---- delegates ----
  delegate :name, to: :user, prefix: true, allow_nil: false

  # ---- validates ----
  validates :url, :text_password, presence: true
  validates :name, :email, presence: true, uniqueness: true
  validates :email, email: true

  # ---- active storage ----
  has_one_attached :logo

  validate :logo_content_type

  private

  def logo_content_type
    return unless logo.attached? && !logo.content_type.in?(%w[image/jpeg image/jpg image/png image/gif])

    errors.add(:logo, 'must be a JPEG, PNG, or GIF')
  end

  public

  # ---- scope ----

  scope :active, -> { where(active: true) }
  scope :in_active, -> { where(active: false) }

  def status
    active ? 'Active' : 'In Active'
  end

  def self.importable_columns
    %i[name url username email text_password key ssh_private_key details ssh_public_key
       ssh_finger_print]
  end
end
