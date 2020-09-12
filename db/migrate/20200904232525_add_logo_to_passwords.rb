# rake db:migrate:down VERSION=20200904232525
class AddLogoToPasswords < ActiveRecord::Migration[5.2]

  def change
    add_attachment :passwords, :logo
  end

end
