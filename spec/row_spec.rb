require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/row'

describe "Row" do
	it "should initialize lockers collection" do
		row = Row.new

		row.lockers.length.should == 0
	end

	it "should add locker" do
		row = Row.new
		row.add_locker :locker, 3

		row.lockers[3].should == :locker
	end

	it "should throw if adding locker on invalid position" do
		row = Row.new
		lambda{row.add_locker :locker, -1}.should raise_error(ArgumentError)
		lambda{row.add_locker :locker, 0}.should raise_error(ArgumentError)
		lambda{row.add_locker :locker, 10}.should raise_error(ArgumentError)
	end

	it "should return false on is_valid when invalid row" do
		row = Row.new
		row.add_locker :locker, 1
		row.add_locker :locker, 2

		row.is_valid?.should == false
	end

	it "should return true on is_valid when valid row" do
		row = Row.new
		row.add_locker :locker1, 1
		row.add_locker :locker2, 2

		row.is_valid?.should == true
	end
end