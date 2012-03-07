# Simple logger class
class TaskLogger

  attr_accessor :name
  attr_accessor :out

  def initialize(name)
    @name = name
    #@out = File.open(File.join(Rails.root,"log","tasks.log"), "a")
    @out = StringIO.new
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

  def text
    @out.string
  end

private 
  def _log(message) 
   puts message
   @out.puts message
   #@out.flush
  end

end
