require File.expand_path(File.dirname(__FILE__) + '/../lib/add')

describe Add do
	before(:each) do
		@add = Add.new('2,500')
	end

  	it "should add value" do
		result_time = @add.on("01:32:04,283")
		result_time.should == "01:32:06,783"
  	end

	it "should manage minutes and seconds wrap" do
		result_time = @add.on("01:32:58,783")
		result_time.should == "01:33:01,283"
	end

	it "should manage hours wrap" do
		result_time = @add.on("01:59:58,783")
		result_time.should == "02:00:01,283"
	end
end
