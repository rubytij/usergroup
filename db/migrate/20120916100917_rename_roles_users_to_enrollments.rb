class RenameRolesUsersToEnrollments < ActiveRecord::Migration
  def change
    rename_table :roles_users, :enrollments
  end
end
