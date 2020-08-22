# rake db:migrate:down VERSION=20200822111438
class AddFingerPrintInPasswords < ActiveRecord::Migration[5.2]

  def change
    add_column :passwords, :ssh_finger_print, :string
  end

end
