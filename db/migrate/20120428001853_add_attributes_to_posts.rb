class AddAttributesToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :name
      t.string :title
      t.text :content
    end
  end
end
