class AbstractPasswordImportService

  def import(import_id)
    raise NotImplementedError "#{self.class} has not implemented method #{__method__}"
  end

end
