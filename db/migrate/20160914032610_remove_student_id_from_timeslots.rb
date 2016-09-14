class RemoveStudentIdFromTimeslots < ActiveRecord::Migration
  def change
  	remove_column :timeslots, :student_id
  	add_column :timeslots, :slots, :integer
  end
end
