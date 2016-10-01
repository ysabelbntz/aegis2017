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
end
