# rake db:migrate:down VERSION=20200907140137
class AddPasswordsUpdatedAt < ActiveRecord::Migration[5.2]
  def change
    add_column :passwords, :password_changed_at, :datetime
    add_column :passwords, :password_copied_at, :datetime
    add_column :passwords, :password_viwed_at, :datetime
  end
end
