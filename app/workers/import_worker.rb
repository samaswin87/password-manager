class ImportWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options queue: 'critical'

  def perform(import_id, klass)
    ImportService.call(import_id, klass)
  end

end
