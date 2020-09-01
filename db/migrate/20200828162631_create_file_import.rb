# rake db:migrate:down VERSION=20200828162631
class CreateFileImport < ActiveRecord::Migration[5.2]
  def change

    create_table :file_imports do |t|
      t.string :state
      t.attachment :data
      t.datetime :completed_at
      t.references :source, index: true, polymorphic: true
      t.text :error_messages
      t.integer :total_count, default: 0
      t.integer :parsed_count, default: 0
      t.integer :failed_count, default: 0
      t.integer :success_count, default: 0
      t.timestamps null: false
    end

  end
end
