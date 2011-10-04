require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/locker'

describe "Locker" do
	it "should initialize value with default constructor" do
		locker = Locker.new
		locker.value = 5

		locker.value.should == 5
	end
	
	it "should initialize value with parametrized constructor" do
		locker = Locker.new(5)

		locker.value.should == 5
	end

	it "should be comparable with other Locker instance" do
		locker1 = Locker.new
		locker1.value = 5

		locker2 = Locker.new
		locker2.value = 1

		locker3 = Locker.new
		locker3.value = 5

		(locker1 == locker2).should == false
		(locker1 == locker3).should == true
	end

	it "should be comparable with other Integer" do
		locker1 = Locker.new
		locker1.value = 5

		(locker1 == 1).should == false
		(locker1 == 5).should == true
	end
	
	it "should allow setting new value" do
		locker = Locker.new
		
		locker.can_set_value?.should == true
	end
end
