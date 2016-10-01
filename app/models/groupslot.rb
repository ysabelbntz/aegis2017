class Groupslot < ActiveRecord::Base
	validates :groupshot_id, presence: true
	validates :student_id, presence: true
	validates :group_name, presence: true
end
