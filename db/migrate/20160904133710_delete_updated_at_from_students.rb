class DeleteUpdatedAtFromStudents < ActiveRecord::Migration
  def change
  	remove_column :students, :created_at
  	remove_column :students, :updated_at
  	remove_column :timeslots, :updated_at
  	remove_column :timeslots, :created_at
  	remove_column :accounts, :created_at
  	remove_column :accounts, :updated_at
  end
end
