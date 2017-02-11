class AddFeedbackToAccounts < ActiveRecord::Migration
  def change
  	add_column :accounts, :feedback, :text
  end
end
