class AdminsController < ApplicationController
	before_filter :authenticate_admin!

	def index
		@students = Student.all.order('id ASC').paginate(:page => params[:page], :per_page => 30)
	end

	def accounts
		@accounts = Account.all.order('student_id ASC').paginate(:page => params[:page], :per_page => 30)

		@account_number = Account.count
	end
end
