class Scenario_Answer
	def initialize
		@answers = Hash.new
	end

	def add_answer_value(value, row, col)
		@answers[[row, col]] = value
	end

	def get_answer_value(row, col)
		@answers[[row, col]]
	end

	def get_answer_coords
		@answers.keys
	end

	def to_s
		@answers.to_s
	end
end