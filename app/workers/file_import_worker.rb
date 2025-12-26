class FileImportWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options queue: 'critical'

  def perform(import_id)
    FileImportService.call(import_id)
  end
end
