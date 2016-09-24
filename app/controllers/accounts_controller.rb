class AccountsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		school = current_account.school
		@events = Event.where(description: ["All", school]).order(:start_time)
	end	

	def sign_ups
		if current_account.timeslot_id.present? 
			@timeslot = Timeslot.find(current_account.timeslot_id)
		else
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

	def slot
		

	end

	def sign_up
		@timeslot = Timeslot.find(params[:format])

		if @timeslot.slots > 0
			current_account.timeslot_id = params[:format]
			current_account.save(validate: false)
			@timeslot.slots = @timeslot.slots - 1
			@timeslot.save

			redirect_to sign_ups_accounts_path
		elsif @timeslot.slots == 0
			flash[:notice] = "Slot already taken."
			redirect_to sign_ups_accounts_path
		end
		
	end

	def photoshoot
		@account = Account.where(student_id: params[:id]).first
		if @account.timeslot_id.present?
			@timeslot = Timeslot.find(@account.timeslot_id)
			@timeslot.slots = @timeslot.slots + 1
			@timeslot.save

			@account.timeslot_id = nil
			@account.save(validate: false)

			flash[:notice] = "Account #{@account.student_id} timeslot reset."
			redirect_to :back
		end
	end

	def slip
		@timeslot = Timeslot.find(current_account.timeslot_id)
		respond_to do |format|
	      format.html
	      format.pdf do
	        render pdf: "confirmation_slip",
	          layout: 'pdf.html.erb',
	          debug: true,
	          template: 'accounts/slip.pdf.erb',
	          show_as_html: params[:debug].present?,
	          margin:  {   top:               10,                     # default 10 (mm)
	                    bottom:            10,
	                    left:              10,
	                    right:             10 }
	      end
	    end
	end
end
