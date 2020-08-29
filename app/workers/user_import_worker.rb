class UserImportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'


  def perform(import_id)
    puts "import: #{import_id}"
  end

end
