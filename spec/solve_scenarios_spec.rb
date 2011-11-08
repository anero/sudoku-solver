require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/solve_scenarios_helper'
require File.dirname(__FILE__) + '/scenario_answer'
require File.dirname(__FILE__) + '/../lib/board'

# Integration tests
describe "Sudoku Solver" do
	it "should solve trivial puzzle" do
		board = Board.new
		answer = Solve_Scenarios_Helper.create_board_from_file board, "./scenarios/trivial.txt"

		board.is_valid?.should == true

		board.solve

		board.is_valid?.should == true

		answer.get_answer_coords.each do |answer_coords|
			row = answer_coords[0]
			col = answer_coords[1]
			board.value_at(row, col).should == answer.get_answer_value(row, col)
		end
	end

	it "should solve advanced puzzle" do
		board = Board.new
		answer = Solve_Scenarios_Helper.create_board_from_file board, "./scenarios/advanced-1.txt"

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