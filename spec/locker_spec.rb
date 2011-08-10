require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/locker'

describe "Locker" do
	it "should initialize with arguments" do
		locker = Locker.new :row, :col, :section

		locker.row.should == :row
		locker.column.should == :col
		locker.section.should == :section
	end

	it "should initialize value" do
		locker = Locker.new :row, :col, :section
		locker.value = 5

		locker.value.should == 5
	end
end