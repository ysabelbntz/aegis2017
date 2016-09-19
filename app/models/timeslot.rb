class Timeslot < ActiveRecord::Base
	has_many :accounts

	def to_s
		self.id.to_s + self.start_time + " " + self.end_time + " " + self.date.to_s + " " + self.slots.to_s
	end
end
