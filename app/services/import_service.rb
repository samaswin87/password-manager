class ImportService < ApplicationService
  def initialize(import_id, user_id, klass)
    @import_id = import_id
    @klass = klass
    @user_id = user_id
    @errors = []
  end

  def call
    raise ArgumentError, "#{@klass} not exist" unless FileImport::SUPPORTED_TYPES.include?(@klass.to_sym)

    instance = "#{@klass.to_s.singularize}_concrete_factory".classify.constantize.new.instance
    return if instance.blank?

    instance.import(@import_id, @user_id)
  end
end
