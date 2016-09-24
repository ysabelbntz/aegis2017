class Timeslot < ActiveRecord::Base
	has_many :accounts, before_add: :validate_user_limit, after_add: :subtract_slots

	def to_s
		self.id.to_s + self.start_time + " " + self.end_time + " " + self.date.to_s + " " + self.slots.to_s
	end

	private

	def validate_user_limit(account)
	    raise Exception.new if accounts.size >= self.slots
	end

	def subtract_slots(account)
		self.slots = self.slots - 1
	end
end
