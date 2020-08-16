class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_on
    self.created_at.strftime("%Y-%m-%d")
  end

  def updated_on
    self.updated_at.strftime("%Y-%m-%d")
  end

  def active!
    unless self.active.nil?
      self.update_attributes(active: false)
    end
  end

  def activate!
    unless self.active.nil?
      self.update_attributes(active: true)
    end
  end

  def destroy
    if self.active
      self.active!
    else
      super()
    end
  end
end
