class AddMinorToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :minor, :string
  end
end
