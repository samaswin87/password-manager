# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :integer
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  gender_id              :bigint
#  user_type_id           :bigint
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  active                 :boolean          default(TRUE)
class User < ApplicationRecord
  # ---- devise ----

  devise :database_authenticatable, :invitable, :recoverable, :registerable,
         :trackable, :timeoutable

  # ---- concerns ----
  importable

  # ---- relationships ----
  belongs_to :user_type
  belongs_to :gender
  has_one :address, as: :linkable, dependent: :destroy
  has_many :passwords, dependent: :delete_all

  # ---- paperclip ----

  has_attached_file :avatar, styles: {
    thumb:  '60x60#',
    medium: '120x120#',
    large:  '230x230#'
  }, default_url: '/vendor/images/img_placeholder.png'

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # ---- validates ----

  validates :user_type, presence: true
  validates :email, presence: true, uniqueness: true

  # ---- callbacks ----

  after_create :invite
  after_create :send_mail


  # ---- nested values ----

  accepts_nested_attributes_for :address

  # ---- default values ----

  # default_value_for :user_type_id, UserType.where(alias: 'administrator').first.id

  # ---- delegates ----

  delegate :name, to: :user_type, prefix: true, allow_nil: true
  delegate :name, to: :gender, prefix: true, allow_nil: true
  delegate :street, :number, :additional_details, :house_name, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true

  # ---- scoped search ----

  scoped_search on: [:first_name, :last_name, :email]

  # ---- scope ----

  scope :active, -> { where(active: true) }
  scope :in_active, -> { where(active: false) }

  # ---- aliases ----

  alias_attribute :name, :full_name

  # ---- methods ----

  def full_name
    "#{first_name} #{last_name}"
  end

  def send_mail
    UserMailer.send_new_user_message(self).deliver
  end

  def invite
    invite! if encrypted_password.blank?
  end

  def status
    self.active ? 'Active' : 'In Active'
  end

  # ---- user types ----

  def admin?
    self.user_type_id == UserType.where(alias: 'administrator').first.id
  end

  def to_hash
    {
      id: self.id,
      first_name: self.first_name,
      last_name: self.last_name,
      email: self.email,
      is_admin: admin?
    }
  end

  def member_since
    self.created_at.strftime("%b, %Y")
  end

  def self.importable_columns
    [:email, :password, :first_name, :last_name, :phone, :gender, :user_type]
  end

end
