class RegistrationsController < Devise::RegistrationsController
	

	  def sign_up_params
	    params.require(resource_name).permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation)
	  end

	  def account_update_params
	    params.require(resource_name).permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation)
	  end  
	  
	  def configure_permitted_parameters
	      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation) }
	  end
end
