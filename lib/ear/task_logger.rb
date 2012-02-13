# Simple logger class
class TaskLogger

  attr_accessor :name

  def initialize(name)
    @name = name
    @out = File.open(File.join(Rails.root,"log","ear.log"), "a")
  end

  def log(message)
    _log "[_] #{@name}: " << message  
  end

  ######
  def log_debug(message) 
    _log "[D] #{@name}: " << message
  end

  def log_good(message)
    _log "[+] #{@name}: " << message
  end

  def log_error(message)
    _log "[-] #{@name}: " << message
  end
  ######

private 
  def _log(message) 
   puts message
   @out.puts message
   @out.flush
  end

end
