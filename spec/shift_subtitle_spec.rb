=begin rdoc
  controllare che se tutti i parametri sono giusti il ritorno è 0

  verificare il formato dei vari parametri che sia corretto
	
=end
require File.expand_path(File.dirname(__FILE__) + '/../lib/shift_subtitle')

describe ShiftSubtitle do
	before :each do
		@messenger = mock('messenger')
		@kernel = mock(Kernel)
		@shift_subtitle = ShiftSubtitle.new(@messenger, @kernel)
	end

	context "starting up" do
		before :each do
			@kernel.should_receive(:exit).with(1)
		end
		
		def start_with(argv=[])
			do_should_print_usage
			@shift_subtitle.start argv
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
		before(:each) do
			@kernel.should_receive(:exit).with(0)
		end
			
		def start_with(argv=[])
			@shift_subtitle.start argv
		end

		context "applied to a subtitle file" do
			it "should create a shifted subtitle file" do
				linetext = [ 
					"645\n",
					"01:31:51,210 --> 01:31:54,893\n",
					"the government is implementing a new policy...\n",
					"\n",
					"646\n",
					"01:31:54,928 --> 01:31:57,664\n",
					"In connection with a dramatic increase\n",
					"in crime in certain neighbourhoods,\n",]
				
				expected = [ 
					"645\n",
					"01:31:53,710 --> 01:31:57,393\n",
					"the government is implementing a new policy...\n",
					"\n",
					"646\n",
					"01:31:57,428 --> 01:32:00,164\n",
					"In connection with a dramatic increase\n",
					"in crime in certain neighbourhoods,\n",]
						
    				File.should_receive(:open).with("infile.srt").and_return(linetext)
				out_file_mock = mock(File)
    				File.should_receive(:open).with("outfile.srt", "w").and_yield(out_file_mock)
				out_file_mock.should_receive(:write).with(expected)

				start_with %w{--operation=add --time=02,500 infile.srt outfile.srt}
			end
		end
	end
end
