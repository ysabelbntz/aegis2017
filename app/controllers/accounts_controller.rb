class AccountsController < ApplicationController

	def index
		@events = Event.all
	end	

	def sign_ups
		case current_account.school
		when "SOH"
			@dates = ["2016-10-17", "2016-10-18", "2016-10-19"]
		when "SOSS"
			@dates = ["2016-10-20","2016-10-21","2016-10-22","2016-10-24","2016-10-25","2016-10-26"]
		when "SOSE"
			@dates = ["2016-10-26", "2016-10-27","2016-10-28","2016-10-29","2016-11-03","2016-11-04"]
		when "SOM"
			@dates = ["2016-11-04","2016-11-07","2016-11-08","2016-11-09","2016-11-10","2016-11-14","2016-11-15"]
		end

		@slots = Timeslot.where(date: @dates).order(:start_time)
	end

	def search 
		idparams = params[:id]
		@student=Account.where(student_id: idparams).first

		respond_to do |format|
			format.html
			format.json {render json: @student}
		end
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
