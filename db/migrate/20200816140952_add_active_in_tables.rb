class AddActiveInTables < ActiveRecord::Migration[5.2]
  def change
    add_column :states, :active, :boolean, default: true
    add_column :cities, :active, :boolean, default: true
    add_column :passwords, :active, :boolean, default: true
  end
end
