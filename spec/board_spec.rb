require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/board'
require File.dirname(__FILE__) + '/../lib/locker'

describe "Board" do
	it "should have all lockers empty after initializing" do
		board = Board.new
		
		(0..8).each {|row_index| (0..8).each {|column_index| board.value_at(column_index, row_index).should == nil } }
	end
	
	it "should add single locker to single row" do
		board = Board.new
		
		board.set_value 1, 1, 1
		board.value_at(1,1).should == 1
	end
	
	it "should add multiple lockers to single row" do
		board = Board.new
		
		board.set_value 1, 1, 1
		board.set_value 9, 1, 2
		board.is_valid?.should == true
		board.value_at(1,1).should == 1
		board.value_at(1,2).should == 9
	end
	
	it "should add multiple lockers to multiple rows" do
		board = Board.new
		
		board.set_value 1, 1, 1
		board.set_value 9, 2, 1
		board.is_valid?.should == true
		board.value_at(1,1).should == 1
		board.value_at(2,1).should == 9
	end
	
	it "should allow duplicated lockers with same value on different row & column" do
		board = Board.new
		
		board.set_value 1, 1, 1
		board.set_value 1, 3, 2
		
		board.is_valid?.should == true
	end
	
	it "should be invalid with duplicate values on same row" do
		board = Board.new
		
		board.set_value 1, 0, 0
		board.set_value 1, 0, 5
		
		board.is_valid?.should == false
	end
	
	it "should be invalid with duplicate values on same column" do
		board = Board.new
		
		board.set_value 1, 0, 0
		board.set_value 1, 5, 0
		
		board.is_valid?.should == false
	end
	
	it "should be invalid with duplicate values on same section" do
		board = Board.new
		
		board.set_value 1, 0, 0
		board.set_value 1, 1, 1
		
		board.is_valid?.should == false
	end
	
	it "should be possible to set value on empty lockers" do
		board = Board.new
		
		board.can_set_value?(0, 0).should == true
	end
	
	it "should be possible to set value on variable lockers" do
		board = Board.new
		
		board.can_set_value?(0, 0).should == true
		board.set_value 1, 0, 0
		
		board.can_set_value?(0, 0).should == true
	end
	
	it "should not be possible to set value on fixed lockers" do
		board = Board.new
		
		board.can_set_value?(0, 0).should == true
		board.set_fixed_value 1, 0, 0		

		board.can_set_value?(0, 0).should == false
		lambda{board.set_value(9, 0, 0)}.should raise_error(RuntimeError)
	end
	
	it "should be possible to set fixed value on variable lockers" do
		board = Board.new
		
		board.set_value 1, 0, 0
		
		board.can_set_value?(0, 0).should == true
		board.set_fixed_value 1, 0, 0		

		board.can_set_value?(0, 0).should == false
	end

	it "should return unused values at position when empty board" do
		board = Board.new

		(0..8).each {|r|
			(0..8).each{|c|
				unused_values = board.unused_values_at_position(r, c)
				(1..9).each { |v| 
					unused_values.include?(v).should == true 
				}
			}
		}
	end

	it "should return unused values at position when fixed value" do
		board = Board.new

		board.set_fixed_value 1, 5, 5
		unused_values = board.unused_values_at_position(5,5)
		unused_values.include?(1).should == false 
		(2..9).each { |v| 
			unused_values.include?(v).should == true 
		}
	end

	it "should return unused values at position when variable value" do
		board = Board.new

		board.set_value 1, 0, 1
		unused_values = board.unused_values_at_position(0,1)
		unused_values.include?(1).should == false 
		(2..9).each { |v| 
			unused_values.include?(v).should == true 
		}
	end

	it "should return unused values at position when multiple values on same row" do
		board = Board.new

		board.set_fixed_value 1, 0, 1
		board.set_fixed_value 2, 0, 2
		unused_values = board.unused_values_at_position(0,1)
		unused_values.include?(1).should == false
		unused_values.include?(2).should == false
		(3..9).each { |v| 
			unused_values.include?(v).should == true 
		}
	end

	it "should return unused values at position when multiple values on same column" do
		board = Board.new

		board.set_fixed_value 1, 0, 1
		board.set_fixed_value 2, 1, 1
		unused_values = board.unused_values_at_position(0,1)
		unused_values.include?(1).should == false
		unused_values.include?(2).should == false
		(3..9).each { |v| 
			unused_values.include?(v).should == true 
		}
	end

	it "should return unused values at position when multiple values on same section" do
		board = Board.new

		board.set_fixed_value 1, 0, 1
		board.set_fixed_value 2, 2, 2
		unused_values = board.unused_values_at_position(0,1)
		unused_values.include?(1).should == false
		unused_values.include?(2).should == false
		(3..9).each { |v| 
			unused_values.include?(v).should == true 
		}
	end
end
