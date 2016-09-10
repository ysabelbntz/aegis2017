class CreateEvents < ActiveRecord::Migration
  def change
  	drop_table :events
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :start_time
      t.date :end_time

      t.timestamps null: false
    end
  end
end
