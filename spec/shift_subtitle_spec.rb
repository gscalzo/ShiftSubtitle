=begin rdoc
  controllare che se tutti i parametri sono giusti il ritorno è 0

  verificare il formato dei vari parametri che sia corretto
	
=end
require File.expand_path(File.dirname(__FILE__) + '/../lib/shift_subtitle')

describe ShiftSubtitle do
	before(:each) do
		@messenger = mock('messenger')
		@shift_subtitle = ShiftSubtitle.new(@messenger)
	end

	def do_should_print_usage
		@messenger.should_receive(:puts).with(
			"Usage: shift_subtitle [OPTIONS] <input_file> <output_file>\n" 			+
			"\n" 										+
			"    -o, --operation=[add|sub]        Type of operation: add or subtract.\n" 	+
			"    -t, --time=<time>                Time to shift in the format 'ss,mmm'\n" 	+
			"\n" 										+
			"    -h, --help                       Show this help message.\n")
		
	end

	context "starting up" do
		after(:each) do
			@result.should == 1
		end
		
		def start_with(argv=[])
			do_should_print_usage
			@result = @shift_subtitle.start argv
		end

		context "with '-h' paramenter"do
			it "should print usage" do
				start_with %w{-h}
			end
		end

		context "without paramenters"do
			it "should print usage" do
				start_with 
			end
		end

		context "with '--operation=add'"do
			it "should have 'add' operation" do
				start_with %w{--operation=add}
				@shift_subtitle.operation.should =='add'
			end
		end

		context "with '--operation=sub'"do
			it "should have 'sub' operation" do
				start_with %w{--operation=sub}
				@shift_subtitle.operation.should =='sub'
			end
		end

		context "with '--time=01,222'"do
			it "should have '01,222' as time" do
				start_with %w{--time=01,222}
				@shift_subtitle.time.should =='01,222'
			end
		end

		context "with 'infile.srt' as inputfile"do
			it "should have 'infile.srt' as inputfile" do
				start_with %w{infile.srt}
				@shift_subtitle.inputfile.should =='infile.srt'
			end
		end
	
		context "with 'outfile.srt' as outputfile"do
			it "should have 'outfile.srt' as outputfile" do
				start_with %w{infile.srt, outfile.srt}
				@shift_subtitle.outputfile.should =='outfile.srt'
			end
		end
	end

	context "starting up" do
		context "with all parameters"do
			before(:each) do
				start_with %w{--operation=add --time=02,123 infile.srt outfile.srt}
			end
			
			def start_with(argv=[])
				@result = @shift_subtitle.start argv
			end

			it "should have all data" do
				@shift_subtitle.operation.should =='add'
				@shift_subtitle.time.should =='02,123'
				@shift_subtitle.inputfile.should =='infile.srt'
				@shift_subtitle.outputfile.should =='outfile.srt'
			end
			it "should return 0" do
				@result.should == 0
			end
		end

	end
end
