require File.dirname(__FILE__) + '/locker'

module Lockers_Collection
	def initialize
		@lockers = []
	end

	def lockers_set_count
		count = 0
		@lockers.each { |v| if (v != nil) then count+=1 end }
		count
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

	def to_s
		s = ""
		(0..8).each { |v| s = "#{s}, #{@lockers[v] != nil ? @lockers[v].to_s : '?'}" }

		s
	end
	
	private
		def is_valid_position?(position)
			return position >= 0 && position <= 8
		end

	protected
		def add_locker(locker, position)
			raise ArgumentError, "Invalid position" unless is_valid_position?(position)
		
			raise ArgumentError, "locker argument is not an instance of Locker" unless locker.kind_of? Locker

			@lockers[position] = locker
		end
		
		def get_locker(position)
			raise ArgumentError, "Invalid position" unless is_valid_position?(position)
		
			@lockers[position]
		end
end
