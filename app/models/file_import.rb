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
#
class FileImport < ApplicationRecord
  has_paper_trail

  # ---- relationships ----
  has_many :import_data_tables, dependent: :delete_all

  # ---- paperclip ----
  has_attached_file :data
  validates_attachment_content_type :data, content_type: ['text/csv', 'text/plain']

  # ---- aasm ----
  aasm column: :state do
    state :pending, initial: true
    state :processing, :falied, :completed

    event :process do
      transitions from: [:pending], to: :processing
    end

    event :abort do
      transitions from: [:pending, :processing], to: :falied
    end

    event :complete do
      transitions from: [:processing], to: :completed, after: Proc.new { set_date }
    end
  end

  # ----- callbacks ----
  validate :supported_type?

  # ----- scopes ----
  scope :for_type, lambda { |data_type|
    where('file_imports.data_type = ?', data_type)
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
  ]

  def parsed_count!(count)
    self.update_attribute(:parsed_count, count)
  end

  def failed_count!(count)
    self.update_attribute(:failed_count, count)
  end

  def success_count!(count)
    self.update_attribute(:success_count, count)
  end

  def total_count!(count)
    self.update_attribute(:total_count, count)
  end

  private

  def set_date
    self.update_attribute(:completed_at, Time.now)
  end

  def supported_type?
    unless SUPPORTED_TYPES.include?(self.data_type.to_sym)
      errors.add(self.data_type, "not valid data type")
    end
  end


end
