class UserImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(import_id)
    UserImportService.call(import_id)
  end

end
