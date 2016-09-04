class AddSchoolToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :school, :string
  end
end
