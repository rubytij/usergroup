class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
     t.string :name, :null => false
     t.string :slug

     t.timestamps
    end

    add_index :sections, :name, :unique => true
    add_index :sections, :slug, :unique => true
  end
end
