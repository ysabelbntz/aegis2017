class AddAccountToStudents < ActiveRecord::Migration
  def change
    add_column :students, :account, :bool
  end
end
