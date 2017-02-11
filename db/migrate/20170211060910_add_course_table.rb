class AddCourseTable < ActiveRecord::Migration
  def change
  	create_table :course_pages do |t|
      t.string :course
      t.integer :page_number
    end
  end
end
