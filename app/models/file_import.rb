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
#  source_type       :string
#  source_id         :bigint
#  error_messages    :text
#  total_count       :integer          default(0)
#  parsed_count      :integer          default(0)
#  failed_count      :integer          default(0)
#  success_count     :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  job_id            :string
class FileImport < ApplicationRecord

  has_paper_trail
  # ---- relationships ----
  belongs_to :source, polymorphic: true

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

end
