class RemoveUrlFieldFromSection < ActiveRecord::Migration
  def change
    remove_column :sections, :url_friendly_name
  end
end
