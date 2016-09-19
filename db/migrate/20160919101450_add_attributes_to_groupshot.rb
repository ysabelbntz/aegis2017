class AddAttributesToGroupshot < ActiveRecord::Migration
  def change
    add_column :groupshots, :start_time, :string
    add_column :groupshots, :end_time, :string
    add_column :groupshots, :slots, :integer
    add_column :groupshots, :date, :string
  end
end
