class PagesController < ApplicationController
	helper_method :resource_name, :resource, :devise_mapping

	def index
		@contact = Contact.new
	end

	def resource_name
	    :account
	end
	 
	def resource
	    @resource ||= Account.new
	end
	 
	def devise_mapping
	    @devise_mapping ||= Devise.mappings[:account]
	end

	
	def not_found
	    respond_to do |format|
	      format.html { render status: 404 }
	    end
  	rescue ActionController::UnknownFormat
	    render status: 404, text: "nope"
	end
end
