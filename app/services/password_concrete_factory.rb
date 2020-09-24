class PasswordConcreteFactory < AbstractFactory

  def instance
    PasswordImportService.new
  end

end
