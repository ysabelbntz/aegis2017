class CreateGroupslots < ActiveRecord::Migration
  def change
    create_table :groupslots do |t|

      t.timestamps null: false
    end
  end
end
