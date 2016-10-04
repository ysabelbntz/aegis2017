class Timeslot < ActiveRecord::Base
	has_many :accounts, before_add: :validate_user_limit, after_add: :subtract_slots

	def to_s
		self.date.strftime("%a, %b %d") + " - " + self.start_time + " - " + self.end_time
	end

	private

	def validate_user_limit(account)
	    raise Exception.new if accounts.size >= self.slots
	end

	def subtract_slots(account)
		self.slots = self.slots - 1
	end
end
