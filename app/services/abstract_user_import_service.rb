class AbstractUserImportService
  def import(_import_id, _user_id)
    raise NotImplementedError "#{self.class} has not implemented method #{__method__}"
  end
end
