class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_uid, null: false
      t.string :name
      t.string :username,   null: false
      t.string :email
      t.string :site_url
      t.string :gravatar_token

      t.datetime :banned_at

      t.timestamps
    end

    add_index :users, :github_uid,  unique: true
    add_index :users, :username,    unique: true
    add_index :users, :email
  end
end
