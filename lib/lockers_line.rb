require File.dirname(__FILE__) + '/locker'

class Lockers_Line
	def initialize
		@lockers = []
	end

	def lockers(position)
		raise ArgumentError, "Invalid position" unless !is_valid_position?(position)
		
		@lockers[position - 1]
	end
	
	def lockers_set_count
		count = 0
		@lockers.each { |v| if (v != nil) then count+=1 end }
		count
	end

	def add_locker(locker, position)
		raise ArgumentError, "Invalid position" unless !is_valid_position?(position)
		
		raise ArgumentError, "locker argument is not an instance of Locker" unless locker.kind_of? Locker

		@lockers[position - 1] = locker
	end

	def is_valid?
		@lockers.inject({}) do |h,v|
			if v != nil
				h[v.value]=h[v.value].to_i+1
			end
			h
		end.reject{|k,v| v==1}.length == 0
	end

	def get_unused_values
		unused_values = []
		(1..9).each {|v| if (!@lockers.include? v) then unused_values.push v end}

		return unused_values
	end
	
	private
		def is_valid_position?(position)
			return position < 1 || position > 9
		end
end
