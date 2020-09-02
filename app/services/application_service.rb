# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
class ApplicationService

  include CsvRowValidator

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
