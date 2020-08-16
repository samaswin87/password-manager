class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_on
    self.created_at.strftime("%Y-%m-%d")
  end

  def updated_on
    self.updated_at.strftime("%Y-%m-%d")
  end
end
