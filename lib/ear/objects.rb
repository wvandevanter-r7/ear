#module EAR

class Object


  def all
    objects = []
    objects << Domain.all
    objects << Finding.all 
    objects << Host.all
    objects << NetBlock.all
    objects << NetSvc.all
    objects << Organization.all
    objects << PhysicalLocation.all
    objects << SearchString.all
    objects << User.all
    objects << WebApp.all
    objects << WebForm.all
  end

  def tasks
    tasks = []
  end

end
