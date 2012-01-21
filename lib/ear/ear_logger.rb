require 'singleton'

# Simple logger class
class EarLogger

  include Singleton

  def initialize
    @out = File.open(File.join(Rails.root,"log","ear.log"), "a")
  end

  def log(message)
    _log "[_] EAR: " << message  
  end

  ######
  def log_debug(message) 
    _log "[D] EAR: " << message
  end

  def log_good(message)
    _log "[+] EAR: " << message
  end

  def log_error(message)
    _log "[-] EAR: " << message
  end
  ######

private 
  def _log(message) 
   @out.puts message
   @out.flush
  end


end
