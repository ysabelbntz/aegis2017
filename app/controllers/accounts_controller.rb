class AccountsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_filter :check_for_cancel, :only => [:add_writeup, :edit_info]

	def index
		@school = current_account.school
		@events = Event.where(description: ["All", @school]).order(:start_time)
		@timeslot = Timeslot.find_by(id: current_account.timeslot_id)
		
		# @groupslot = Groupslot.find_by(student_id: current_account.student_id)
		
		if @groupslot.present?
			@groupshot = Groupshot.find_by(id: @groupslot.groupshot_id)
		end
	end	

	def group_signups
		@checkgroupslot = Groupslot.where(student_id: current_account.student_id)
		if @checkgroupslot.count > 0
			@has_groupshot = true
			@checkgroupslot = @checkgroupslot.first
			@timeslot = Groupshot.find(@checkgroupslot.groupshot_id)
		end
		@slots = Groupshot.all.order(:date).order(:start_time)
		@dates = ["2016-11-16", "2016-11-17", "2016-11-18", "2016-11-19", "2016-11-21", "2016-11-22", "2016-11-23"]
	end

	def sign_ups
		if current_account.timeslot_id.present? 
			@timeslot = Timeslot.find(current_account.timeslot_id)
		end

		@dates = ["2016-10-17", "2016-10-18", "2016-10-19", "2016-10-20","2016-10-21","2016-10-22","2016-10-24","2016-10-25","2016-10-26", "2016-10-27","2016-10-28","2016-10-29","2016-11-03","2016-11-04","2016-11-07","2016-11-08","2016-11-09","2016-11-10","2016-11-14","2016-11-15"]

		@slots = Timeslot.where(date: @dates).order(:start_time)
	end

	def search 
		idparams = params[:id]
		@student=Account.where(student_id: idparams).first

		if @student.timeslot_id.nil?
			@timeslot = "No timeslot."
		else
			@timeslot = Timeslot.find(@student.timeslot_id).to_s
		end

		respond_to do |format|
			format.html
			format.json {render json: @student, methods: :get_timeslot}
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

	def reschedule
		@timeslot = Timeslot.find_by(id: current_account.timeslot_id)
		@timeslot.slots = @timeslot.slots + 1
		@timeslot.save

		current_account.timeslot_id = nil
		current_account.rescheduled = true
		current_account.save(validate: false)

		flash[:alert] = "Timeslot reset."
		redirect_to :back
	end

	def sign_up
	# 	@timeslot = Timeslot.find(params[:slot_id])

	# 	if @timeslot.slots > 0
			
	# 		@timeslot.slots = @timeslot.slots - 1
	# 		if @timeslot.slots < 0
	# 			flash[:alert] = "Slot already taken."
	# 			redirect_to sign_ups_accounts_path
	# 		else
	# 			@timeslot.save
	# 			current_account.timeslot_id = params[:slot_id]
	# 			current_account.save(validate: false)
	# 		end

	# 		redirect_to sign_ups_accounts_path
	# 	elsif @timeslot.slots == 0
	# 		flash[:alert] = "Slot already taken."
	# 		redirect_to sign_ups_accounts_path
	# 	end
		flash[:alert] = "You may not sign up."
		redirect_to :back
	end

	def group_signup
	# 	@timeslot = Timeslot.find(params[:slot_id])

	# 	if params[:group_name] != "" or params[:group_name].present?
	# 		if @timeslot.slots > 0 
	# 			@timeslot.slots = @timeslot.slots - 1
				
	# 			if @timeslot.slots < 0
	# 				flash[:alert] = "Slot already taken."
	# 				redirect_to group_signups_accounts_path
	# 			else
	# 				@timeslot.save
	# 				@groupslot = Groupslot.new
	# 				@groupslot.student_id = current_account.student_id
	# 				@groupslot.groupshot_id = params[:slot_id]
	# 				@groupslot.group_name = params[:group_name]
	# 				@groupslot.save
	# 				redirect_to group_signups_accounts_path
	# 			end
	# 		elsif @timeslot.slots == 0
	# 			flash[:alert] = "Slot already taken."
	# 			redirect_to group_signups_accounts_path
	# 		end
	# 	else
	# 		flash[:alert] = "Please enter a group name."
	# 		redirect_to group_signups_accounts_path
	# 	end
		flash[:alert] = "You may not sign up."
		redirect_to :back
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

	def groupslip
		@groupslot = Groupslot.where(student_id: current_account.student_id).first
		@timeslot = Groupshot.find(@groupslot.groupshot_id)


		respond_to do |format|
	      format.html
	      format.pdf do
	        render pdf: "group_confirmation_slip",
	          layout: 'pdf.html.erb',
	          debug: true,
	          template: 'accounts/groupslip.pdf.erb',
	          show_as_html: params[:debug].present?,
	          margin:  {   top:               10,                     # default 10 (mm)
	                    bottom:            10,
	                    left:              10,
	                    right:             10 }
	      end
	    end
	end

	def check_for_cancel
	  if params[:commit] == "Cancel"
	    redirect_to view_writeup_accounts_path
	  end
	end

	def timeslots
		@dates = []
		@dates_g = []
		Timeslot.where(type: nil).distinct(:date).order(:date).pluck(:date).each do |timeslot|
			instance_variable_set "@slots_#{timeslot.to_s.underscore}".to_sym, Timeslot.where(date: timeslot)
			@dates << "#{timeslot.to_s.underscore}"
		end

		Groupshot.distinct(:date).order(:date).pluck(:date).each do |timeslot|
			instance_variable_set "@slots_#{timeslot.to_s.underscore}".to_sym, Timeslot.where(date: timeslot)
			@dates_g << "#{timeslot.to_s.underscore}"
		end
	end

	def view_writeup
		@account = current_account
		#if !current_account.can_write
			#redirect_to accounts_path
		#end
	end

	def add_writeup
		@account = current_account

		if current_account.final_writeup
			redirect_to view_writeup_accounts_path
		elsif !current_account.can_write
			redirect_to accounts_path
		end
	end

	def admin_writeup
		@student = Account.find_by(student_id: params[:id])

		if @student.present? 
			if @student.writeup.present?
				flash[:notice] = "Student #{params[:id]} has a write-up."
				redirect_to :back
			else
				@student.update_attributes(writeup: params[:writeup])
				@student.update_attributes(final_writeup: true)
				flash[:notice] = "Student #{params[:id]} write-up added."
				redirect_to :back
			end
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	def submit_writeup

	end

	def submit_final_writeup 
		current_account.update(final_writeup:  true)
		redirect_to edit_info_accounts_path
	end

	def edit_info
		@account = current_account
	end

	def reset_writeup 
		@student = Account.find_by(student_id: params[:id])

		if @student.present? 
			@student.update_attributes(final_writeup: false)
			flash[:notice] = "Student #{params[:id]} write-up set to temporary status."
			redirect_to :back
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	def reset_feedback
		@student = Account.find_by(student_id: params[:id])

		if @student.present? 
			@student.update_attributes(feedback: nil)
			flash[:notice] = "Student #{params[:id]} feedback resetted."
			redirect_to :back
		else
			flash[:notice] = "Student #{params[:id]} not found."
			redirect_to :back
		end
	end

	def yearbook_preview
		@casualshot = current_account.yearbook_shot
		@togashots = CoursePage.select('page_number').where(course: current_account.course.upcase)
	end

	def addfeedback

		feedback = "["+params[:page_number]+"]"+"["+params[:name]+"]"+"["+params[:feedback]+"]"
		current_account.feedback = feedback
		current_account.save

		flash[:success] = "Feedback submitted!"
		redirect_to :back
	end

	def update		
		# if params[:writeup_submit]
		# 	@account = current_account
		# 	@account.update_attributes!(account_params)
		# 	redirect_to view_writeup_accounts_path
		# elsif params[:account_submit]
		# 	@account = current_account
		# 	@account.update_attributes!(account_params)
		# 	redirect_to accounts_path
		# else
			# redirect_to accounts_path
		# end

		current_account.update_attribute(:feedback, params[:feedback])
		flash[:success] = "Feedback submitted!"
		redirect_to yearbook_preview_path
	end

	def account_params
	  params.require(:account).permit(:writeup, :double_major, :minor, :cellphone_number, :full_course, :second_status, :email, :feedback)
	end
end
