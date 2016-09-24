class AddBelongsToTimeslot < ActiveRecord::Migration
  def change
  	add_reference :accounts, :timeslot, index: true
    add_foreign_key :accounts, :timeslots
  end
end
