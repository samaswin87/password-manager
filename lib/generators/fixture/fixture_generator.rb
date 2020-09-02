class FixtureGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def create_fixture
    fixture_name = file_name.pluralize
    template 'fixture.rb.tt', File.join('test/fixtures', "#{fixture_name}.yml")
  end

  private

  def columns
    @columns = []
    klass_name = file_name.camelize.singularize(:en)
    if klass_name.constantize
      @columns = klass_name.constantize.column_names
    end
    @columns
  end

end
