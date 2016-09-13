class AccountsController < ApplicationController

	def index

	end	

	def destroy 
		@account = Account.find(params[:id])
		@student = Student.find(@account.student_id)
		@student.update_attribute(:account, false)

	    @account.destroy

	    if @account.destroy
	        redirect_to accounts_admins_path, notice: "Account #{@account.student_id} deleted."
	    end
	end
end
