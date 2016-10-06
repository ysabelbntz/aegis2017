# sd = Date.parse('2016-11-16')
# ed = Date.parse('2016-11-23')

# sd.upto(ed) { |day|
# 	Groupshot.create({start_time: "8:00 AM", end_time: "9:00 AM", date: day, slots: 18})
# 	Groupshot.create({start_time: "9:00 AM", end_time: "10:00 AM", date: day, slots: 18})
# 	Groupshot.create({start_time: "10:00 AM", end_time: "11:00 AM", date: day, slots: 18})
# 	Groupshot.create({start_time: "11:00 AM", end_time: "12:00 AM", date: day, slots: 18})
# 	Groupshot.create({start_time: "12:00 AM", end_time: "1:00 PM", date: day, slots: 18})
# 	Groupshot.create({start_time: "1:00 PM", end_time: "2:00 PM", date: day, slots: 18})
# 	Groupshot.create({start_time: "2:00 PM", end_time: "3:00 PM", date: day, slots: 18})
# 	Groupshot.create({start_time: "3:00 PM", end_time: "4:00 PM", date: day, slots: 18})
# 	Groupshot.create({start_time: "4:00 PM", end_time: "5:00 PM", date: day, slots: 18})
# 	Groupshot.create({start_time: "5:00 PM", end_time: "6:00 PM", date: day, slots: 18})
# }

# Account.all.each do |account|
# 	student = Student.find(account.student_id)
# 	student.account = true
# 	student.save(validate: false)
# end

# Timeslot.where(type: nil).each do |timeslot|
# 	@accounts = Account.where(timeslot_id: timeslot.id).count

# 	if @accounts != (14 - timeslot.slots)
# 		timeslot.slots = 14 - @accounts
# 		timeslot.save
# 	end
# end

@groupslots = Groupslot.group(:student_id).having('count("student_id") > 1').count(:student_id)

@groupslots.each do |key, value|

  # Keep one and return rest of the duplicate records

  duplicates = Groupslot.where(student_id: key)[1..value-1]

  puts "#{key} = #{duplicates.count}"

  # Destroy duplicates and their dependents

  duplicates.each(&:destroy)

end
