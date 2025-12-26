# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
class ApplicationService
  include CsvRowValidator

  def self.call(*, &)
    new(*, &).call
  end

  protected

  def options
    { force_utf8: true, convert_values_to_numeric: true }
  end
end
