#          Column         |            Type             | Collation | Nullable |              Default
# ------------------------+-----------------------------+-----------+----------+-----------------------------------
#  id                     | bigint                      |           | not null | nextval('users_id_seq'::regclass)
#  email                  | character varying           |           | not null | ''::character varying
#  encrypted_password     | character varying           |           | not null | ''::character varying
#  reset_password_token   | character varying           |           |          |
#  reset_password_sent_at | timestamp without time zone |           |          |
#  sign_in_count          | integer                     |           | not null | 0
#  current_sign_in_at     | timestamp without time zone |           |          |
#  last_sign_in_at        | timestamp without time zone |           |          |
#  current_sign_in_ip     | inet                        |           |          |
#  last_sign_in_ip        | inet                        |           |          |
#  failed_attempts        | integer                     |           | not null | 0
#  unlock_token           | character varying           |           |          |
#  locked_at              | timestamp without time zone |           |          |
#  invitation_token       | character varying           |           |          |
#  invitation_created_at  | timestamp without time zone |           |          |
#  invitation_sent_at     | timestamp without time zone |           |          |
#  invitation_accepted_at | timestamp without time zone |           |          |
#  invitation_limit       | integer                     |           |          |
#  invited_by_id          | integer                     |           |          |
#  invited_by_type        | integer                     |           |          |
#  first_name             | character varying           |           |          |
#  last_name              | character varying           |           |          |
#  phone                  | character varying           |           |          |
#  gender_id              | bigint                      |           |          |
#  user_type_id           | bigint                      |           |          |
#  avatar_file_name       | character varying           |           |          |
#  avatar_content_type    | character varying           |           |          |
#  avatar_file_size       | integer                     |           |          |
#  avatar_updated_at      | timestamp without time zone |           |          |
#  created_at             | timestamp without time zone |           | not null |
#  updated_at             | timestamp without time zone |           | not null |
#  active                 | boolean                     |           |          | true
class User < ApplicationRecord
  # ---- devise ----

  devise :database_authenticatable, :invitable, :recoverable, :registerable,
         :trackable, :timeoutable

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

  scope :valid, -> { where(active: true) }

  # ---- aliases ----

  alias_attribute :name, :full_name

  # ---- methods ----

  def full_name
    "#{first_name} #{last_name}"
  end

  def invite
    invite! if encrypted_password.blank?
  end

  # ---- user types ----

  def admin?
    user_type_id == UserType.where(alias: 'administrator').first.id
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

end
