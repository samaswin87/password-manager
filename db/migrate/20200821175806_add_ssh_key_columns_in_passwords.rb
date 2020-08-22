# rake db:migrate:down VERSION=20200821175806
class AddSshKeyColumnsInPasswords < ActiveRecord::Migration[5.2]

  def change
    add_column :passwords, :ssh_public_key, :text
    rename_column :passwords, :ssh, :ssh_private_key
  end

end
