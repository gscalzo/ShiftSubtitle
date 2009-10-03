class OperationPerformer
	def initialize(o)
		@operate=o
	end

	def on(input)
		input.map { |value|
			perform(value)
		}
	end
	private
	def perform(value)
		if value =~ /\d{2}:\d{2}:\d{2},\d{3} --> \d{2}:\d{2}:\d{2},\d{3}/ then
			evaluate(value)
		else
			value
		end
	end

	def evaluate(value)
		dates=value.split(' --> ')
		dates = dates.map {|x|
			x.strip
		}
		"#{@operate.on(dates[0])} --> #{@operate.on(dates[1])}"	
	end
end
