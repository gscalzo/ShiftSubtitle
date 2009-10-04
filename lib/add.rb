$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'operation'


class Add < Operation
	def operation(a,b)
		as_time(a) + b
	end
end


