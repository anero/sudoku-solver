require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/solve_scenarios_helper'
require File.dirname(__FILE__) + '/scenario_answer'
require File.dirname(__FILE__) + '/../lib/board'

# Integration tests
describe "Sudoku Solver" do
	it "should solve trivial puzzle" do
		board = Board.new
		answer = Scenario_Answer.new

		File.open("./scenarios/trivial.txt", "r") do |infile|
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
								if (locker_value != "?") then board.set_fixed_value Integer(locker_value), rowIndex, colIndex end
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

		board.is_valid?.should == true

		board.solve

		board.is_valid?.should == true

		answer.get_answer_coords.each do |answer_coords|
			row = answer_coords[0]
			col = answer_coords[1]
			board.value_at(row, col).should == answer.get_answer_value(row, col)
		end
	end
end