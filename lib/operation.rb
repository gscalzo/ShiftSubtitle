class Operation
	def initialize(v)
		@value = as_float(v)
	end

	def on(time_to_adjust)
		format(operation(time_to_adjust, @value))
	end

	private
	def usec(value)
		value[-3..-1].to_i * 1000
	end

	def as_float(v)
		v.sub(/,/,'.').to_f
	end

	def as_time(time_to_adjust)
		d = Date._strptime(date_to_adjust(time_to_adjust),"%m-%d-%Y %H:%M:%S")
		Time.utc(d[:year], d[:mon], d[:mday], d[:hour], d[:min], 
         			d[:sec], usec(time_to_adjust))
	end

	def date_to_adjust(time_to_adjust)
		"01-01-2009 " + time_to_adjust[0..-5]
	end

	def format(t)
		t.strftime("%H:%M:%S,") + "#{t.usec/1000}"
	end
end

