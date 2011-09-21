require File.dirname(__FILE__) + '/locker'
require File.dirname(__FILE__) + '/lockers_collection'

class Lockers_Line
	include Lockers_Collection
	
	def set_locker(locker, position)
		self.add_locker locker, position
	end
	
	def locker(position)
		self.get_locker position
	end
end
