class UserConcreteFactory < AbstractFactory

  def instance
    UserImportService.new
  end

end
