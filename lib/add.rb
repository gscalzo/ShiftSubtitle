require File.expand_path(File.dirname(__FILE__) + '/../lib/operation')

class Add < Operation
	def operation(a,b)
		as_time(a) + b
	end
end


