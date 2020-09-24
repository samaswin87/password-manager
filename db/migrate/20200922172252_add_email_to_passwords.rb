# rake db:migrate:down VERSION=20200922172252
class AddEmailToPasswords < ActiveRecord::Migration[5.2]

  def change
    add_column :passwords, :email, :string
    add_column :file_imports, :parsed_data, :jsonb
  end

end
