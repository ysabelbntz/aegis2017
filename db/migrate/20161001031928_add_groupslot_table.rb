class AddGroupslotTable < ActiveRecord::Migration
  def change
  	change_table :groupslots do |t|
	  t.integer :groupshot_id, null: false
	  t.integer :student_id, null: false
	  t.string :group_name, null: false
	  t.index :groupshot_id
	  t.index :student_id
	end
  end
end
