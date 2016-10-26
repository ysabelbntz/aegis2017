class CreateWriteupAccounts < ActiveRecord::Migration
  def change
    create_table :writeup_accounts do |t|
      t.integer :idnumber
    end
  end
end
