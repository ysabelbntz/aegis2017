class CreateGroupshots < ActiveRecord::Migration
  def change
    create_table :groupshots do |t|

      t.timestamps null: false
    end
  end
end
