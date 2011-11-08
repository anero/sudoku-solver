require File.dirname(__FILE__) + '/scenario_answer'
require File.dirname(__FILE__) + '/../lib/board'

class Solve_Scenarios_Helper
	def self.create_board_from_file(board, scenario_file_path)
		answer = Scenario_Answer.new

		File.open(scenario_file_path, "r") do |infile|
			rowIndex = 0
			answers_section = false
			while (line = infile.gets)
				colIndex = 0
				if (line == "\n") then
					answers_section = true
					rowIndex = 0
				else
					if (!answers_section) then
						line.split(//).each do |locker_value|
							if (locker_value != "\n") then
								if (locker_value != "?") then
									board.set_fixed_value Integer(locker_value), rowIndex, colIndex 
								end
								colIndex = colIndex + 1
							end
						end
					else
						line.split(//).each do |answer_value|
							if (answer_value != "\n") then
								if (answer_value != ".") then answer.add_answer_value Integer(answer_value), rowIndex, colIndex end
								colIndex = colIndex + 1
							end
						end
					end
					rowIndex = rowIndex + 1
				end
			end
		end

		answer
	end
end