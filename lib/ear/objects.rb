  #module EAR

class Object

  def all
    objects = []
    Domain.all.each {|x| objects << x } unless Domain.all == [] 
    Finding.all.each {|x| objects << x }  unless Finding.all == []  
    Host.all.each {|x| objects << x }  unless Host.all == [] 
    NetBlock.all.each {|x| objects << x }  unless NetBlock.all == [] 
    NetSvc.all.each {|x| objects << x }  unless NetSvc.all == []
    Organization.all.each {|x| objects << x }  unless Organization.all == []
    PhysicalLocation.all.each {|x| objects << x }   unless PhysicalLocation.all == []
    SearchString.all.each {|x| objects << x }  unless SearchString.all == []
    User.all.each {|x| objects << x }  unless User.all == []
    WebApp.all.each {|x| objects << x }  unless WebApp.all == []
    WebForm.all.each {|x| objects << x }  unless WebForm.all == []
    
    objects
  end

  def tasks
    tasks = []
  end

end
