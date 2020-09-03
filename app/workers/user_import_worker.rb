class UserImportWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: 'critical'

  def perform(import_id, field_maps)
    UserImportService.call(import_id, field_maps)
  end

end
