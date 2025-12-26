# rake db:migrate:down VERSION=20200816041557
class CreatePasswords < ActiveRecord::Migration[5.2]
  def change
    create_table :passwords do |t|
      t.string :name
      t.string :url
      t.string :username
      t.string :password
      t.string :key
      t.text :ssh
      t.text :details

      # Paperclip attachment columns (will be moved to password_attachments table later)
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.bigint   :attachment_file_size
      t.datetime :attachment_updated_at

      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
