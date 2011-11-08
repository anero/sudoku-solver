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
		@rows[row].locker(col).value unless @rows[row].locker(col) == nil
	end
	
	def can_set_value?(row, col)
		if (@rows[row].locker(col) != nil) then @rows[row].locker(col).can_set_value?
		else return true
		end
	end
	
	def set_value(value, row, col)
		if (@rows[row].locker(col) == nil) then add_locker(Locker.new(value), row, col)
		else 
			@rows[row].locker(col).value = value
			@columns[col].locker(row).value = value
		
			section_index = get_section_index_from_row_and_col(row, col)
			inner_section_row = get_section_inner_row_from_row_and_col(section_index, row, col)
			inner_section_col = get_section_inner_col_from_row_and_col(section_index, row, col)
			@sections[section_index].locker(inner_section_row, inner_section_col).value = value
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
		find_solution_value 0, 0
		puts "\nSOLUTION:\n---------\n#{self}\n\n"
	end

	def unused_values_at_position(row, col)
		unused_values_at_row = @rows[row].get_unused_values
		unused_values_at_col = @columns[col].get_unused_values
		section_index = get_section_index_from_row_and_col(row, col)
		unused_values_at_section = @sections[section_index].get_unused_values
		unused_values = []
		(1..9).each{|v|
			if (unused_values_at_row.include?(v) && unused_values_at_col.include?(v) && unused_values_at_section.include?(v))
				unused_values.push v
			end				
		}

		unused_values
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

		def get_next_locker_position(row, col)
			if row == 8 && col == 8 then return :end_position end

			if (row < 8 && col == 8) then
				row = row + 1
				col = 0
			elsif (row <= 8 && col < 8) then
				col = col + 1
			end

			return [row, col]
		end
		
		def add_locker(locker, row, col)
			@rows[row].set_locker(locker, col)
			@columns[col].set_locker(locker, row)
		
			section_index = get_section_index_from_row_and_col(row, col)
			inner_section_row = get_section_inner_row_from_row_and_col(section_index, row, col)
			inner_section_col = get_section_inner_col_from_row_and_col(section_index, row, col)
			@sections[section_index].set_locker(locker, inner_section_row, inner_section_col)
		end

		def find_solution_value(row, column)
			if (value_at(row, column) == nil) then
				unused_values_at_position(row, column).each{ |uv|
					set_value(uv, row, column)
					next_position = get_next_locker_position(row, column)
					if (next_position != :end_position) then
						find_solution_value(next_position[0], next_position[1])
					end
				}
			else
				next_position = get_next_locker_position(row, column)
				if (next_position != :end_position) then
					find_solution_value(next_position[0], next_position[1])
				end
			end
		end
end
