class Locker
	attr_accessor :value

	def initialize(*args)
		if args.size == 1
			raise ArgumentError, "value argument is not an instance of Integer" unless args[0].kind_of? Integer
			@value = args[0]
		end
	end

	def ==(another_value)
		case another_value
			when Integer then @value == another_value
			when Locker then @value == another_value.value
			else false
		end
	end

	def can_set_value?
		true
	end
end
