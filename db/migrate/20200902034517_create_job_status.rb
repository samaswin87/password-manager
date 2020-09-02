# rake db:migrate:down VERSION=20200902034517
class CreateJobStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :job_statuses do |t|
      t.string :job_id
      t.text :error_messages
      t.integer :percentage, default: 0
      t.timestamps null: false
    end

    add_reference :file_imports, :job_status, index: true, null: true

  end
end
