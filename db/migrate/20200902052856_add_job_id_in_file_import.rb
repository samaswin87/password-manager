# rake db:migrate:down VERSION=20200902052856
class AddJobIdInFileImport < ActiveRecord::Migration[5.2]
  def change
    add_column :file_imports, :job_id, :string
  end
end
