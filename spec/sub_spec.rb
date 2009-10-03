require File.expand_path(File.dirname(__FILE__) + '/../lib/sub')

describe Sub do
	before(:each) do
		@sub = Sub.new('2,500')
	end

  	it "should sub value" do
		result_time = @sub.to("01:32:04,783")
		result_time.should == "01:32:02,283"
  	end

	it "should manage minutes and seconds wrap" do
		result_time = @sub.to("01:32:02,283")
		result_time.should == "01:31:59,783"
	end

	it "should manage hours wrap" do
		result_time = @sub.to("02:00:02,283")
		result_time.should == "01:59:59,783"
	end

end
