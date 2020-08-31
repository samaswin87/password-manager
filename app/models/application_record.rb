class ApplicationRecord < ActiveRecord::Base
  include AASM
  include Importable

  self.abstract_class = true

  def created_on
    self.created_at.date_only
  end

  def updated_on
    self.updated_at.date_only
  end

  def active!
    unless self.active.nil?
      self.toggle!(:active)
    end
  end

end
