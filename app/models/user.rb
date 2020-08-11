class User < ActiveRecord::Base
  # ---- devise ----

  devise :database_authenticatable, :invitable, :recoverable, :registerable,
         :trackable, :timeoutable

  # ---- relationships ----

  belongs_to :user_type
  belongs_to :gender
  has_one :address, as: :linkable, dependent: :destroy

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
  delegate :street, :number, :district, :complement, :city_name,
           :state_name, :zipcode, to: :address, prefix: true, allow_nil: true

  # ---- scoped search ----

  scoped_search on: [:first_name, :last_name, :email]

  # ---- scope ----

  scope :valid, -> { where.not(id: 1) }

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
end
