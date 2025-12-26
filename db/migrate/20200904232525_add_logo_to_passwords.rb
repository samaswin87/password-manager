# rake db:migrate:down VERSION=20200904232525
class AddLogoToPasswords < ActiveRecord::Migration[5.2]
  def change
    add_column :passwords, :logo_file_name, :string
    add_column :passwords, :logo_content_type, :string
    add_column :passwords, :logo_file_size, :bigint
    add_column :passwords, :logo_updated_at, :datetime
  end
end
