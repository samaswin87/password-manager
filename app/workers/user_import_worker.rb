class UserImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(import_id, fiel_maps)
    UserImportService.call(import_id, fiel_maps)
  end

end
