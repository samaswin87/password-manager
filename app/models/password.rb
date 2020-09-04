# == Schema Information
#
# Table name: passwords
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  url                     :string
#  username                :string
#  text_password           :string
#  key                     :string
#  ssh_private_key         :text
#  details                 :text
#  attachment_file_name    :string
#  attachment_content_type :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  user_id                 :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  active                  :boolean          default(TRUE)
#  ssh_public_key          :text
#  ssh_finger_print        :string
#  logo_file_name          :string
#  logo_content_type       :string
#  logo_file_size          :bigint
#  logo_updated_at         :datetime
#
class Password < ApplicationRecord
  # ---- relationships ----
  belongs_to :user

  # ---- delegates ----
  delegate :name, to: :user, prefix: true, allow_nil: false

  # ---- validates ----

  validates :url, :text_password, presence: true
  validates :name, presence: true, uniqueness: true
  # ---- paperclip ----
  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => ['application/pdf', /\Aimage\/.*\z/, "application/zip", "application/x-zip"]

  before_post_process :skip_for_zip

  # ---- scope ----

  scope :active, -> { where(active: true) }
  scope :in_active, -> { where(active: false) }

  def status
    self.active ? 'Active' : 'In Active'
  end

  private

  def skip_for_zip
     ! %w(application/zip application/x-zip).include?(attachment_content_type)
  end

end
