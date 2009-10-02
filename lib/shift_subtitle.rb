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

	public
	def initialize(messenger)
		@messenger = messenger
	end

	def start(argv=[])
		options = {}
		optparse = OptionParser.new do |o|
			o.banner = "Usage: shift_subtitle [OPTIONS] <input_file> <output_file>"
			o.separator   ""
			o.on("-o", "--operation=[add|sub]", String,
	       			"Type of operation: add or subtract.")   do |options[:operation]| end
			o.on("-t", "--time=<time>", String,
	       			"Time to shift in the format 'ss,mmm'")   do |options[:time]| end
			o.separator   ""
			o.on_tail("-h", "--help", "Show this help message.") do 
				@messenger.puts o.to_s; 
				return 1
			end
			o.parse!(argv)
		end
			
		@operation = options[:operation]
		@time = options[:time]
		@inputfile = argv[0]
		@outputfile = argv[1]
		unless parameters_valid?
		  @messenger.puts optparse.to_s
		  return 1
		end

		return 0
	end
end
if $0 == __FILE__
	shift_subtitle = ShiftSubtitle.new(STDOUT)
	shift_subtitle.start(ARGV)
end
