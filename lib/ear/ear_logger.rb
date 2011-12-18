require 'singleton'

# Simple logger class
class EarLogger

	include Singleton

	def log(message)
		puts "[.] EAR: " << message	
	end

	######
	def log_debug(message) 
		puts "[x] EAR: " << message
	end

	def log_good(message)
		puts "[+] EAR: " << message
	end

	def log_error(message)
		puts "[-] EAR: " << message
	end
	######

end
