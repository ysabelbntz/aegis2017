class UpdateAccountAttributes < ActiveRecord::Migration
  def change
  	change_table :accounts do |t|
      t.change :name, :string
      t.change :course, :string
    end
    change_table :students do |t|
      t.change :name, :string
      t.change :course, :string
    end
  end
end
