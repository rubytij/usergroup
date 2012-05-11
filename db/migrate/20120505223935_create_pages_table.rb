class CreatePagesTable < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string    :name, :null => false
      t.integer   :section_id, :null => false
      t.string    :title
      t.string    :tags
      t.text      :content
      t.datetime  :created_on
      t.integer   :created_by
      t.datetime  :last_update
      t.integer   :last_update_by
    end

    add_index :pages, :name, :unique => true
  end
end
