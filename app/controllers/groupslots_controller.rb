class GroupslotsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def reset
		@groupslot = Groupslot.where(student_id: params[:id]).first
		@timeslot = Timeslot.find(@groupslot.groupshot_id)
		@timeslot.slots = @timeslot.slots + 1
		@timeslot.save

		@groupslot.destroy

		flash[:notice] = "#{@groupslot.group_name} timeslot resetted."
		redirect_to :back	
	end

	def clean_groups
		@groupslots = Groupslot.group(:student_id).having('count("student_id") > 1').count(:student_id)

		@message = []
		@groupslots.each do |key, value|

		  # Keep one and return rest of the duplicate records

		  duplicates = Groupslot.where(student_id: key)[1..value-1]

		  @message << "#{key} = #{duplicates.count}"

		  # Destroy duplicates and their dependents

		  duplicates.each(&:destroy)

		end

		flash[:notice] = "#{@message} resetted."
		redirect_to :back	
	end
end
