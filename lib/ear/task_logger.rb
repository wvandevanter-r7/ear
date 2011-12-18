# Simple logger class
class TaskLogger

	def initialize(name)
		@name = name
	end

	def log(message)
		puts "[x] #{@name}: " << message	
	end

	######
	def log_debug(message) 
		puts "[d] #{@name}: " << message
	end

	def log_good(message)
		puts "[+] #{@name}: " << message
	end

	def log_error(message)
		puts "[-] #{@name}: " << message
	end
	######

end
