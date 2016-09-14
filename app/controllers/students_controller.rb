class StudentsController < ApplicationController
	respond_to :json, :html
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
end