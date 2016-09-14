sd = Date.parse('2016-11-21')
ed = Date.parse('2016-11-23')

sd.upto(ed) { |day|
	Timeslot.create({start_time: "8:00 AM", end_time: "9:00 AM", date: day, slots: 18})
	Timeslot.create({start_time: "9:00 AM", end_time: "10:00 AM", date: day, slots: 18})
	Timeslot.create({start_time: "10:00 AM", end_time: "11:00 AM", date: day, slots: 18})
	Timeslot.create({start_time: "11:00 AM", end_time: "12:00 AM", date: day, slots: 18})
	Timeslot.create({start_time: "12:00 AM", end_time: "1:00 PM", date: day, slots: 18})
	Timeslot.create({start_time: "1:00 PM", end_time: "2:00 PM", date: day, slots: 18})
	Timeslot.create({start_time: "2:00 PM", end_time: "3:00 PM", date: day, slots: 18})
	Timeslot.create({start_time: "3:00 PM", end_time: "4:00 PM", date: day, slots: 18})
	Timeslot.create({start_time: "4:00 PM", end_time: "5:00 PM", date: day, slots: 18})
	Timeslot.create({start_time: "5:00 PM", end_time: "6:00 PM", date: day, slots: 18})
}