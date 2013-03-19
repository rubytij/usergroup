class AddIndexToUserGithubUrl < ActiveRecord::Migration
  def change
    add_index :users, :github_username, :unique => true
  end
end
