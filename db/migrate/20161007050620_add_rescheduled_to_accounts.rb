class AddRescheduledToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :rescheduled, :boolean
  end
end
