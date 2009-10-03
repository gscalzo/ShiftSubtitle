require 'optparse'

class ShiftSubtitle
	attr :operation
	attr :time
	attr :inputfile
	attr :outputfile

	private
	def parameters_valid?
		@operation && @time && @inputfile && @outputfile
	end

	def parse(argv)
		options = {}
		optparse = OptionParser.new do |o|
			o.banner = "Usage: shift_subtitle [OPTIONS] <input_file> <output_file>"
			o.separator   ""
			o.on("-o", "--operation=[add|sub]", String,
	       			"Type of operation: add or subtract.")   do |options[:operation]| end
			o.on("-t", "--time=<time>", String,
	       			"Time to shift in the format 'ss,mmm'")   do |options[:time]| end
			o.separator   ""
			o.on_tail("-h", "--help", "Show this help message.") do |options[:help]| end
			o.parse!(argv)
		end
		return options, optparse.to_s
	end

	def save_options(options, argv)
		@operation = options[:operation]
		@time = options[:time]
		@inputfile = argv[0]
		@outputfile = argv[1]
	end

	public
	def initialize(messenger)
		@messenger = messenger
	end

	def start(argv=[])
		options, usage_msg = parse argv
		save_options options, argv
		if !parameters_valid? || options[:help] 
		  @messenger.puts usage_msg
		  return 1
		end

		return 0
	end
end
