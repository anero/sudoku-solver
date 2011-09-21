require File.dirname(__FILE__) + '/lockers_line'
require File.dirname(__FILE__) + '/lockers_collection'

class Lockers_Section
	include Lockers_Collection
	
	def set_locker(locker, row_number, col_number)
		raise ArgumentError, "Invalid position" unless is_valid_section_position?(row_number, col_number)
		
		position = get_position_from_row_and_col row_number, col_number
		self.add_locker locker, position
	end
	
	def locker(row_number, col_number)
		raise ArgumentError, "Invalid position" unless is_valid_section_position?(row_number, col_number)
		
		position = get_position_from_row_and_col row_number, col_number
		self.get_locker position
	end
	
	private 
		def is_valid_section_position?(row_number, col_number)
			return row_number >= 0 && row_number <= 2 && col_number >= 0 && col_number <= 2
		end
		
		def get_position_from_row_and_col(row_number, col_number)
			row_number * 3 + col_number
		end
end
