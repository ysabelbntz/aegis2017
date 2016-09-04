class AddStudentIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :student_id, :integer
  end
end
