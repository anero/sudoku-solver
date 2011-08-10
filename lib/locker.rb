class Locker
	def initialize row, column, section
		self.row = row
		self.column = column
		self.section = section
	end

	attr_accessor :row, :column, :section
	attr_reader :value

	def value=(lockerValue)
		@value = lockerValue
	end
end