class AddFeedback2ToAccounts < ActiveRecord::Migration
  def change
  	rename_column :accounts, :feedback, :old_feedback
  	add_column :accounts, :feedback, :text
  end
end
