class Row
	def initialize
		@lockers = []
	end

	attr_reader :lockers

	def add_locker(locker, position)
		if position < 1 || position > 9 then
			raise ArgumentError, "Invalid position"
		end

		@lockers[position] = locker
	end

	def is_valid?
		@lockers.inject({}) {|h,v| h[v]=h[v].to_i+1; h}.reject{|k,v| v==1}.length == 0
	end
end