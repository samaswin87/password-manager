class ApplicationRecord < ActiveRecord::Base
  include AASM
  include Importable

  self.abstract_class = true

  def created_on
    created_at.date_only
  end

  def updated_on
    updated_at.date_only
  end

  def active!
    return if active.nil?

    update!(active: !active)
  end

  def to_s
    attributes.map { |key, value| "#{key}=#{value}" }.join(', ')
  end

  # Must override by child classes
  def self.importable_columns
    []
  end
end
