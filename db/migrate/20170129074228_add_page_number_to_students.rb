class AddPageNumberToStudents < ActiveRecord::Migration
  def change
    add_column :students, :page_number, :integer
  end
end
