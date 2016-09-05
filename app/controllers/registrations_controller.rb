class RegistrationsController < Devise::RegistrationsController
	skip_before_filter :verify_authenticity_token, :only => :create	
	def create
		super do
			Student.find(params[:account][:id]).update(account: true)	
		end
	end

	protected
	  def sign_up_params
	    params.require(resource_name).permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation, :id)
	  end

	  def account_update_params
	    params.require(resource_name).permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation)
	  end  
	  
	  def configure_permitted_parameters
	      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation, :id) }
	      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
	  end
end
