$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'operation'


class Sub < Operation
	def operation(a,b)
		as_time(a)-b
	end
end
