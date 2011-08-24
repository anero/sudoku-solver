require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/board'
require File.dirname(__FILE__) + '/../lib/locker'

describe "Board" do
	it "should have all lockers empty after initializing" do
		board = Board.new
		
		(1..9).each {|row_index| (1..9).each {|column_index| board.value_at(column_index, row_index).should == nil } }
	end
	
	it "should add single locker to single row" do
		board = Board.new
		
		board.add_locker Locker.new(1), 1, 1
		board.value_at(1,1).should == Locker.new(1)
	end
	
	it "should add multiple lockers to single row" do
		board = Board.new
		
		board.add_locker Locker.new(1), 1, 1
		board.add_locker Locker.new(9), 1, 2
		board.is_valid?.should == true
		board.value_at(1,1).should == Locker.new(1)
		board.value_at(1,2).should == Locker.new(9)
	end
	
	it "should add multiple lockers to multiple rows" do
		board = Board.new
		
		board.add_locker Locker.new(1), 1, 1
		board.add_locker Locker.new(9), 2, 1
		board.is_valid?.should == true
		board.value_at(1,1).should == Locker.new(1)
		board.value_at(2,1).should == Locker.new(9)
	end
	
	it "should allow duplicated lockers with same value on different row & column" do
		board = Board.new
		
		board.add_locker Locker.new(1), 1, 1
		board.add_locker Locker.new(1), 2, 1
		
		board.is_valid?.should == true
	end
end
