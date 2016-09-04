class StudentsController < ApplicationController
	respond_to :json, :html
	def search 
		idparams = params[:id]
		@student=Student.where(id: idparams)
		
		respond_to do |format|
			format.html
			format.json {render json: @student}
		end
	end
end