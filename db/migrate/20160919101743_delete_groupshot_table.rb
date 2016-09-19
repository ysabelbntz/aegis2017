class DeleteGroupshotTable < ActiveRecord::Migration
  def change
  	drop_table :groupshots
  end
end
