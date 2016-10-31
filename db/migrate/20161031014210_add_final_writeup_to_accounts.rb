class AddFinalWriteupToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :final_writeup, :boolean
  end
end
