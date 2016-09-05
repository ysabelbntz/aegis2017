class StudentsController < ApplicationController
	respond_to :json, :html
	def search 
		idparams = params[:id]
		@student=Student.where(id: idparams)
		
		@account=Account.where(student_id: idparams)

		if @account.present?
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
end