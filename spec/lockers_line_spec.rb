require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/lockers_line'

describe "Lockers_Line" do
	it "should initialize lockers collection" do
		lockers_line = Lockers_Line.new

		lockers_line.lockers_set_count.should == 0
	end

	it "should add locker" do
		lockers_line = Lockers_Line.new
		locker = Locker.new
		lockers_line.add_locker locker, 3

		lockers_line.lockers(3).should == locker
	end

	it "should throw if adding locker on invalid position" do
		lockers_line = Lockers_Line.new
		lambda{lockers_line.add_locker Locker.new, -1}.should raise_error(ArgumentError)
		lambda{lockers_line.add_locker Locker.new, 0}.should raise_error(ArgumentError)
		lambda{lockers_line.add_locker Locker.new, 10}.should raise_error(ArgumentError)
	end

	it "should return false on is_valid when invalid lockers_line" do
		lockers_line = Lockers_Line.new
		lockers_line.add_locker Locker.new(1), 1
		lockers_line.add_locker Locker.new(1), 2

		lockers_line.is_valid?.should == false
	end

	it "should return true on is_valid when valid lockers_line" do
		lockers_line = Lockers_Line.new
		lockers_line.add_locker Locker.new(1), 1
		lockers_line.add_locker Locker.new(2), 2

		lockers_line.is_valid?.should == true
	end
	
	it "should replace locker when adding on same position" do
		lockers_line = Lockers_Line.new
		lockers_line.add_locker Locker.new(1), 1
		lockers_line.add_locker Locker.new(9), 1
		
		lockers_line.lockers_set_count.should == 1
		lockers_line.lockers(1).should == 9
	end

	it "should return unused values" do
		lockers_line = Lockers_Line.new

		lockers_line.add_locker Locker.new(1), 1
		lockers_line.add_locker Locker.new(9), 2

		unused_values = lockers_line.get_unused_values

		unused_values.length.should == 7
		unused_values.include?(1).should == false
		unused_values.include?(2).should == true
		unused_values.include?(3).should == true
		unused_values.include?(4).should == true
		unused_values.include?(5).should == true
		unused_values.include?(6).should == true
		unused_values.include?(7).should == true
		unused_values.include?(8).should == true
		unused_values.include?(9).should == false
	end	
end
