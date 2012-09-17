class AddMissingIndicesOnRoles < ActiveRecord::Migration
  def change
    add_index :roles, :name
    add_index :roles, :authorizable_type
    add_index :roles, :authorizable_id
    add_index :roles, [ :name, :authorizable_type, :authorizable_id ], :unique => true
  end
end
