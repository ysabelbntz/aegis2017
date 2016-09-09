class AddIndexToStudents < ActiveRecord::Migration
  def change
    add_index :accounts, :student_id
  end
end
