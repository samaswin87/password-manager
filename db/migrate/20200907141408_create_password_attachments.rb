# rake db:migrate:down VERSION=20200907141408
class CreatePasswordAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :password_attachments do |t|
      # Paperclip attachment columns
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.bigint   :attachment_file_size
      t.datetime :attachment_updated_at

      t.references :password, index: true, foreign_key: true
      t.timestamps
    end

    remove_column :passwords, "attachment_file_name"
    remove_column :passwords, "attachment_content_type"
    remove_column :passwords, "attachment_file_size"
    remove_column :passwords, "attachment_updated_at"
  end
end
