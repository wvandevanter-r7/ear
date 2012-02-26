  #module EAR

class Object

  def all
    objects = []
    objects << Domain.all unless Domain.all == [] 
    objects << Finding.all unless Finding.all == []  
    objects << Host.all unless Host.all == [] 
    objects << NetBlock.all unless NetBlock.all == [] 
    objects << NetSvc.all unless NetSvc.all == []
    objects << Organization.all unless Organization.all == []
    objects << PhysicalLocation.all  unless PhysicalLocation.all == []
    objects << SearchString.all unless SearchString.all == []
    objects << User.all unless User.all == []
    objects << WebApp.all unless WebApp.all == []
    objects << WebForm.all unless WebForm.all == []
    
    objects
  end

  def tasks
    tasks = []
  end

end
