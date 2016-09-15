class StudentsController < ApplicationController
	# encoding: utf-8
	respond_to :json, :html
	skip_before_action :verify_authenticity_token

	def search 
		idparams = params[:id]
		@student=Student.where(id: idparams)

		if @student[0].account
			respond_to do |format|
				format.html
				format.json {render json: [{name:"Account already created.",yr:"",course:"",school:""}]}
			end
		else
			respond_to do |format|
				format.html
				format.json {render json: @student}
			end
		end
	end

	def admin_search 
		idparams = params[:id]
		@student=Student.where(id: idparams).first

		
		respond_to do |format|
			format.html
			format.json {render json: @student}
		end
	end

	def reset
		@student = Student.find(params[:id])
		@student.update_attributes(account: false)
		flash[:notice] = "Student #{@student.id} account set to false."
		redirect_to :back
	end

	def transfer
		@student = Student.find(params[:id])
		@account = Account.where(student_id: params[:id]).first

		@account.name = @student.name
		@account.yr = @student.yr
		@account.course = @student.course
		@account.school = @student.school

		@account.save(validate: false)

		flash[:notice] = "Student #{@student.id} account details restored."
		redirect_to :back		
	end
end