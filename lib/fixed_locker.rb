require File.dirname(__FILE__) + '/locker'

class Fixed_Locker < Locker
	def value
		@value
	end
	
	def value=(newValue)
		raise RuntimeError, "value cannot be set"
	end

	def can_set_value?
		false
	end
end
