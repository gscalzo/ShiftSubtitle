$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'operation_performer'
require 'add'
require 'sub'
require 'optparse'

class ShiftSubtitle
	private
	def parameters_valid?
		operation_valid? && time_valid? && @inputfile && @outputfile
	end

	def operation_valid?
		@operation && (@operation == 'add' || @operation == 'sub')
	end

	def time_valid?
		@time && @time =~ /\d?\d,\d{3}/
	end

	def parse(argv)
		options = {}
		optparse = OptionParser.new do |o|
			o.banner = "Usage: shift_subtitle [OPTIONS] <input_file> <output_file>"
			o.separator   ""
			o.on("-o", "--operation [add|sub]", String,
	       			"Type of operation: add or subtract.")   do |options[:operation]| end
			o.on("-t", "--time <time>", String,
	       			"Time to shift in the format 'ss,mmm'")   do |options[:time]| end
			o.separator   ""
			o.on_tail("-h", "--help", "Show this help message.") do |options[:help]| end
			o.parse!(argv)
		end
		options_to_attr options, argv
		return optparse.to_s
	end

	def options_to_attr(options, argv)
		@operation = options[:operation]
		@time = options[:time]
		@inputfile = argv[0]
		@outputfile = argv[1]
		@help = options[:help]
	end

	def print_parameters
		@messenger.puts "Shifting with following parameters:\n" +
				"\n"					+
				"Operation:   [#{@operation}]\n"	+
				"Time:        [#{@time}]\n"		+
				"Input file:  [#{@inputfile}]\n"	+
				"Output file: [#{@outputfile}]"
	end

	def operation
		@operation == 'add' ? Add.new(@time) : Sub.new(@time)
	end

	def inputlines
		File.open(@inputfile).map { |line| line.chomp }
	end

	def processed_lines
		OperationPerformer.new(operation).on(inputlines).map { |line| line + "\n" }
	end

	def write_to_outputfile(lines)
		File.open(@outputfile, 'w') do |f| 
			f.write lines
		end
	end

	public
	def initialize(messenger,kernel=Kernel)
		@messenger = messenger
		@kernel = kernel
	end

	def start(argv=[])
		usage_msg = parse argv
		if !parameters_valid? || @help 
			@messenger.puts usage_msg
			@kernel.exit 1
		else
			print_parameters
			write_to_outputfile processed_lines
			@kernel.exit 0
		end
	end
end
