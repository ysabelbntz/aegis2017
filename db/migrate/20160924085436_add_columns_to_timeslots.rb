class AddColumnsToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :group_name, :string
    add_column :accounts, :groupshot_id, :integer
  end
end
