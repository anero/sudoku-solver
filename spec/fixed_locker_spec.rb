require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/fixed_locker'

describe "Fixed_Locker" do
	it "should not allow setting new value" do
		fixed_locker = Fixed_Locker.new
		
		fixed_locker.can_set_value?.should == false
		lambda{fixed_locker.value=(1)}.should raise_error(RuntimeError)
	end
end
