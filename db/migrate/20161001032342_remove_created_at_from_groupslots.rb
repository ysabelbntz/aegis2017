class RemoveCreatedAtFromGroupslots < ActiveRecord::Migration
  def change
  	remove_column :groupslots, :created_at
  	remove_column :groupslots, :updated_at
  	remove_column :timeslots, :group_name
  	drop_table :groupshots
  end
end
