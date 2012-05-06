class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
     t.string :name, :null => false
     t.string :description
     t.string :status
    end

  add_index :sections, :name, :unique => true
  end
end
