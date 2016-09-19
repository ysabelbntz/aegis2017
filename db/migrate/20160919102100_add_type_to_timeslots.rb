class AddTypeToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :type, :string
  end
end
