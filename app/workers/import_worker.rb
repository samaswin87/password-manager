class ImportWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options queue: 'critical'

  def perform(import_id, user_id, klass)
    ImportService.call(import_id, user_id, klass)
  end
end
