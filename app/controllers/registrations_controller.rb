class RegistrationsController < Devise::RegistrationsController
	skip_before_filter :verify_authenticity_token, :only => :create	
	def create
		super do
			Student.find(params[:account][:id]).update(account: true)	
		end
	end

	

	protected

		def after_sign_up_path_for(resource)
	    # check for the class of the object to determine what type it is
		    if resource.class == Admin
		      admins_path
		    elsif resource.class == Account
		      accounts_path
		    end 
		end

		
	  def sign_up_params
	    params.require(resource_name).permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation, :id)
	  end

	  def account_update_params
	    params.require(resource_name).permit(:id, :name, :yr, :course, :school, :email, :password, :password_confirmation)
	  end  
	  
	  def configure_permitted_parameters
	      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:student_id, :name, :yr, :course, :school, :email, :password, :password_confirmation, :id) }
	      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :remember_me, :id) }
	  end
end
