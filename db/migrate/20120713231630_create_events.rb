class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string     :name
      t.datetime   :start_date
      t.datetime   :end_date
      t.text       :description
      t.references :user
      t.timestamps
    end
  end
end
