class AddSecondStatusToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :second_status, :string
  end
end
