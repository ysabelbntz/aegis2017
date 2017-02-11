class CoursePage < ActiveRecord::Base
	def page_num
		
	    case self.page_number.to_s.length
	    when 2
	      return '/pics/00'+self.page_number.to_s+'.pdf'
	    when 3
	      return '/pics/0'+self.page_number.to_s+'.pdf'
	    when 4
	      return '/pics/'+self.page_number.to_s+'.pdf'
	    end
	end
end
