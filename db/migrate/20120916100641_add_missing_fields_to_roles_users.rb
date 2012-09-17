class AddMissingFieldsToRolesUsers < ActiveRecord::Migration
  def change
    add_column :roles_users, :created_at, :datetime
    add_column :roles_users, :updated_at, :datetime
    add_column :roles_users, :id,         :primary_key
  end
end
