class ShiftSubtitle
	attr :operation

	def initialize(messenger)
		@messenger = messenger
	end

	def start(argv=[])
		@messenger.puts "Usage: shift_subtitle --operation [ add | sub ] --time <time> <input_file> <output_file>"
		@operation = 'add'
	end
end
