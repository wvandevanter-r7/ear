# Simple logger class
class TaskLogger

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def log(message)
    puts "[_] #{@name}: " << message  
  end

  ######
  def log_debug(message) 
    puts "[D] #{@name}: " << message
  end

  def log_good(message)
    puts "[+] #{@name}: " << message
  end

  def log_error(message)
    puts "[-] #{@name}: " << message
  end
  ######

end
