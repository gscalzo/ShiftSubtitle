$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'operation_performer'
require 'add'

describe OperationPerformer do
	context "with parameters" do
		before(:each) do
			@perform = OperationPerformer.new(Add.new('2,500'))
		end

		it "should return a list of string" do
			input = ['645',
				'01:31:51,210 --> 01:31:54,893',
				'the government is implementing a new policy...']			
			output = @perform.on(input)

			output.should be_an_instance_of(Array)
		end

		it "should add given value" do
			input = ['645',
				'01:31:51,210 --> 01:31:54,893 ',
				'the government is implementing a new policy...']			
			output = @perform.on(input)

			expected = ['645',
				'01:31:53,710 --> 01:31:57,393',
				'the government is implementing a new policy...']			
			output.should == expected
		end
	end
end
