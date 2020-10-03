# rake db:migrate:down VERSION=20201003165023
class ChangeAddressAssociation < ActiveRecord::Migration[5.2]

  def change
    remove_reference :addresses, :linkable, polymorphic: true, index: true
    add_reference :addresses, :user, index: true
    add_foreign_key :addresses, :users
    add_reference :addresses, :country, index: true
    add_foreign_key :addresses, :countries
    add_column :addresses, :type, :integer, default: 1
  end

end
