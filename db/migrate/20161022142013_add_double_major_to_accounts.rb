class AddDoubleMajorToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :double_major, :string
  end
end
