require File.dirname(__FILE__) + '/lockers_line'

class Board
	def initialize
		@rows = []
		(0..8).each {|i| @rows[i] = Lockers_Line.new }
	end
	
	def value_at(col, row)
		@rows[col - 1].lockers(row)
	end
	
	def add_locker(locker, col, row)
		@rows[col - 1].add_locker(locker, row)
	end
	
	def is_valid?
		valid = true
		(0..8).each {|i| valid = valid && @rows[i].is_valid? }
		
		valid
	end
end
