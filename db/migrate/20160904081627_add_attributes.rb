class AddAttributes < ActiveRecord::Migration
  def change
  	add_column :students, :name, :text
  	add_column :students, :yr, :integer
  	add_column :students, :course, :text
  	
  	add_column :accounts, :name, :text
  	add_column :accounts, :yr, :integer
  	add_column :accounts, :course, :text
  	add_column :accounts, :writeup, :text

  	add_column :timeslots, :start_time, :text
  	add_column :timeslots, :end_time, :text
  	add_column :timeslots, :date, :date
  	add_column :timeslots, :student_id, :integer

  	

  end
end
