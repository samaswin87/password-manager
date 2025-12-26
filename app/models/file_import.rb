# == Schema Information
#
# Table name: file_imports
#
#  id                :bigint           not null, primary key
#  state             :string
#  data_file_name    :string
#  data_content_type :string
#  data_file_size    :integer
#  data_updated_at   :datetime
#  completed_at      :datetime
#  error_messages    :text
#  total_count       :integer          default(0)
#  parsed_count      :integer          default(0)
#  failed_count      :integer          default(0)
#  success_count     :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  job_id            :string
#  data_type         :string
#  headers           :string           default([]), is an Array
#  mappings          :jsonb            not null
#  parsed_data       :jsonb
#
class FileImport < ApplicationRecord
  has_paper_trail

  # ---- relationships ----
  has_many :import_data_tables, dependent: :delete_all

  # ---- active storage ----
  has_one_attached :data

  validate :data_content_type

  private

  def data_content_type
    return unless data.attached? && !data.content_type.in?(%w[text/csv text/plain])

    errors.add(:data, 'must be a CSV or text file')
  end

  public

  # ---- aasm ----
  aasm column: :state do
    state :uploading, initial: true
    state :pending, :importing, :mapping, :processing, :falied, :completed

    event :import do
      transitions from: [:uploading], to: :importing
    end

    event :map do
      transitions from: [:importing], to: :mapping
    end

    event :process do
      transitions from: %i[mapping pending], to: :processing
    end

    event :abort do
      transitions from: %i[pending processing], to: :falied
    end

    event :complete do
      transitions from: [:processing], to: :completed, after: proc { set_date }
    end
  end

  # ----- callbacks ----
  validate :supported_type?

  # ----- scopes ----
  scope :for_type, lambda { |data_type|
    where(file_imports: { data_type: data_type })
  }

  # ----- statics ----
  PASSWORDS = :passwords
  USERS = :users
  STATES = :states
  CITIES = :cities

  SUPPORTED_TYPES = [
    PASSWORDS,
    USERS,
    STATES,
    CITIES
  ].freeze

  def parsed_count!(count)
    update!(parsed_count: count)
  end

  def failed_count!(count)
    update!(failed_count: count)
  end

  def success_count!(count)
    update!(success_count: count)
  end

  def total_count!(count)
    update!(total_count: count)
  end

  def table_headers
    table_headers = []
    mappings.each_key do |header|
      table_headers << I18n.t("model.#{data_type}.fields.#{header}")
    end

    table_headers
  end

  private

  def set_date
    update!(completed_at: Time.zone.now)
  end

  def supported_type?
    return false if SUPPORTED_TYPES.include?(data_type.to_sym)

    errors.add(data_type, 'not valid data type')
  end
end
