require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/lockers_section'

describe "Lockers_Section" do
	it "should add lockers" do
		lockers = []
		(0..8).each {|locker_value| lockers[locker_value] = Locker.new locker_value }
		lockers_section = Lockers_Section.new
		
		locker_index = 0
		(0..2).each {|row_index| (0..2).each { |column_index|
			lockers_section.set_locker lockers[locker_index], row_index, column_index
			locker_index =+ 1
		} }
		
		locker_index = 0
		(0..2).each {|row_index| (0..2).each { |column_index| 
			lockers_section.locker(row_index, column_index).should == lockers[locker_index]
			locker_index =+ 1
		} }
	end
	
	it "should replace existing lockers" do
		lockers_section = Lockers_Section.new
		locker1 = Locker.new 1
		locker2 = Locker.new 2
		
		lockers_section.set_locker locker1, 0, 2
		lockers_section.locker(0, 2).should == locker1
		
		lockers_section.set_locker locker2, 0, 2
		lockers_section.locker(0, 2).should == locker2
	end
end
