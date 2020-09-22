class ImportService < ApplicationService

  def initialize(import_id, klass)
    @import_id = import_id
    @klass = klass
    @errors = []
  end

  def call
    instance = nil
    unless FileImport::SUPPORTED_TYPES.include?(@klass.to_sym)
      raise ArgumentError, "#{@klass} not exist"
    end

    instance = "#{@klass.to_s.singularize}_concrete_factory".classify.constantize.new.instance
    if instance.present?
      instance.import(@import_id)
    end
  end

end
