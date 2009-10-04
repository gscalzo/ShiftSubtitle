=begin rdoc
  controllare che se tutti i parametri sono giusti il ritorno è 0

  verificare il formato dei vari parametri che sia corretto
	
=end
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'shift_subtitle'

describe ShiftSubtitle do
	before :each do
		@messenger = mock('messenger', :null_object => true)
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
				"    -o, --operation [add|sub]        Type of operation: add or subtract.\n" 	+
				"    -t, --time <time>                Time to shift in the format 'ss,mmm'\n" 	+
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

		context "with part of parameters"do
			it "should print usage" do
				start_with %w{--operation add}
			end
			it "should print usage" do
				start_with %w{--time 01,222}
			end
		end

		context "with only inputfile"do
			it "should print usage" do
				start_with %w{infile.srt}
			end
		end
	
		context "with inputfile and outfile without options"do
			it "should print usage" do
				start_with %w{infile.srt, outfile.srt}
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

		context "with all parameters" do
			it "should print all parameters" do
				@messenger.should_receive(:puts).with(
					"Shifting with following parameters:\n" +
					"\n" 				    +
					"Operation:   [add]\n"              +	
					"Time:        [02,500]\n"           +	
					"Input file:  [infile.srt]\n"       +	
					"Output file: [outfile.srt]"	    )

    				File.should_receive(:open).with("infile.srt").and_return([])
				out_file_mock = mock(File, :null_object => true)
    				File.should_receive(:open).with("outfile.srt", "w").and_yield(out_file_mock)

				start_with %w{--operation add --time 02,500 infile.srt outfile.srt}
			end

			def mock_file(inputlines, outputlines)
    				File.should_receive(:open).with("infile.srt").and_return(inputlines)
				out_file_mock = mock(File)
    				File.should_receive(:open).with("outfile.srt", "w").and_yield(out_file_mock)
				out_file_mock.should_receive(:write).with(outputlines)
			end


			context "and add as operation" do
				it "should create a shifted subtitle file" do
					inputlines = [ 
						"645\n",
						"01:31:51,210 --> 01:31:54,893\n",
						"the government is implementing a new policy...\n",
						"\n",
						"646\n",
						"01:31:54,928 --> 01:31:57,664\n",
						"In connection with a dramatic increase\n",
						"in crime in certain neighbourhoods,\n",]
					expectedlines = [ 
						"645\n",
						"01:31:53,710 --> 01:31:57,393\n",
						"the government is implementing a new policy...\n",
						"\n",
						"646\n",
						"01:31:57,428 --> 01:32:00,164\n",
						"In connection with a dramatic increase\n",
						"in crime in certain neighbourhoods,\n",]
					mock_file(inputlines, expectedlines)						
					start_with %w{--operation add --time 02,500 infile.srt outfile.srt}
				end
			end

			context "and sub as operation" do
				it "should create a shifted subtitle file" do
					inputlines = [ 
						"645\n",
						"01:31:51,210 --> 01:31:54,893\n",
						"the government is implementing a new policy...\n",
						"\n",
						"646\n",
						"01:31:54,928 --> 01:31:57,664\n",
						"In connection with a dramatic increase\n",
						"in crime in certain neighbourhoods,\n",]
					expectedlines = [ 
						"645\n",
						"01:31:48,710 --> 01:31:52,393\n",
						"the government is implementing a new policy...\n",
						"\n",
						"646\n",
						"01:31:52,428 --> 01:31:55,164\n",
						"In connection with a dramatic increase\n",
						"in crime in certain neighbourhoods,\n",]
						
					mock_file(inputlines, expectedlines)						
					start_with %w{--operation sub --time 02,500 infile.srt outfile.srt}
				end
			end
			
		end
	end
end
