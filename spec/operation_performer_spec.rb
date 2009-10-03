=begin rdoc
	controllare la questione della virgola e del punto
=end
require File.expand_path(File.dirname(__FILE__) + '/../lib/operation_performer')

describe OperationPerformer do
	context "with parameters" do
		it "should return a list of string" do
			input = %w{645,
				01:31:51,210 --> 01:31:54,893,
				the government is implementing a new policy...}			
			output = OperationPerformer.new('add','2,500').on(input)

			output.should be_an_instance_of(Array)
		end
		it "should add given value" do
			pending
			input = %w{645,
				01:31:51,210 --> 01:31:54,893,
				the government is implementing a new policy...}			
			output = OperationPerformer.new('add','2,500').on(input)

			expected = %w{645,
				01:31:53,710 --> 01:31:57,393,
				the government is implementing a new policy...}			
			output.should == expected
		end

	end
end
