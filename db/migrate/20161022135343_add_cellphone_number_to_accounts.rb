class AddCellphoneNumberToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :cellphone_number, :string
  end
end
