class AddMissingIndicesOnRolesUsers < ActiveRecord::Migration
  def change
    add_index :roles_users, :user_id
    add_index :roles_users, :role_id
    add_index :roles_users, [ :user_id, :role_id ], unique: true
  end
end
