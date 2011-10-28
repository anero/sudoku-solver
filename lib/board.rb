require File.dirname(__FILE__) + '/lockers_line'
require File.dirname(__FILE__) + '/lockers_section'
require File.dirname(__FILE__) + '/fixed_locker'
require File.dirname(__FILE__) + '/locker'

class Board
	def initialize
		@rows = []
		@columns = []
		@sections = []
		(0..8).each { |i| 
			@rows[i] = Lockers_Line.new
			@columns[i] = Lockers_Line.new
			@sections[i] = Lockers_Section.new
		}
	end
	
	def value_at(row, col)
		# locker value can be get from any of the 3 collections (rows, columns or sections) which must be kept at sync at all times
		@rows[col].locker(row).value unless @rows[col].locker(row) == nil
	end
	
	def can_set_value?(row, col)
		if (@rows[col].locker(row) != nil) then @rows[col].locker(row).can_set_value?
		else return true
		end
	end
	
	def set_value(value, row, col)
		if (@rows[col].locker(row) == nil) then add_locker(Locker.new(value), row, col)
		else @rows[col].locker(row).value = value
		end
	end
	
	def set_fixed_value(value, row, col)
		if (can_set_value?(row, col) == true) then add_locker(Fixed_Locker.new(value), row, col)
		else raise RuntimeError, "value cannot be set"
		end
	end
	
	def is_valid?
		valid = true
		(0..8).each {|i| valid = valid && @rows[i].is_valid? && @columns[i].is_valid? && @sections[i].is_valid? }
		
		valid
	end
	
	def to_s
		s = ""
		(0..8).each { |row_index| 
			(0..8).each { |column_index|
				value = self.value_at(row_index, column_index)
				s = "#{s}, #{value != nil ? value : '?'}"
				if (column_index == 8) then s = "#{s}\n" end
			}
		}

		s
	end

	def solve
	end

	private
		def get_section_index_from_row_and_col(row, col)
			3 * (col / 3) + (row / 3)
		end
		
		def get_section_inner_row_from_row_and_col(section_index, row, col)
			row % 3
		end
		
		def get_section_inner_col_from_row_and_col(section_index, row, col)
			col % 3
		end
		
		def add_locker(locker, row, col)
			@rows[col].set_locker(locker, row)
			@columns[row].set_locker(locker, col)
		
			section_index = get_section_index_from_row_and_col(row, col)
			inner_section_row = get_section_inner_row_from_row_and_col(section_index, row, col)
			inner_section_col = get_section_inner_col_from_row_and_col(section_index, row, col)
			@sections[section_index].set_locker(locker, inner_section_row, inner_section_col)
		end
end
