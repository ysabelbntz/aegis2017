class AddFullCourseToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :full_course, :string
  end
end
