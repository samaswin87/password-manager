# rake db:migrate:down VERSION=20200823091207
class ChangePasswordFieldName < ActiveRecord::Migration[5.2]

  def change
    rename_column :passwords, :password, :text_password
  end

end
