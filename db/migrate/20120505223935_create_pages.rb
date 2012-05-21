class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string    :name,    :null => false
      t.string    :section, :null => false
      t.string    :title,   :null => false
      t.text      :content, :null => false
      t.string    :slug

      t.timestamps
    end

    add_index :pages, :name,    :unique => true
    add_index :pages, :slug,    :unique => true
  end
end
