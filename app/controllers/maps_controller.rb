class MapsController < ApplicationController
  # GET /maps
  # GET /maps.json
  def index
    @loc = PhysicalLocation.all
    
    #f = File.open("#{File.dirname(__FILE__)}/../../public/listing.js","w")
    @json =  "var sweetObj = {\'locations\': ["
    @loc.each do |loc|
      display  = ""
      
      loc.parents.each do |x| 
        display = x.to_s
          x.children.each do |y| 
          display << " / " << y.to_s
        end
      end
      

      
      @json << "{\n\'name\': \'#{display}\',\n\'position\': [#{loc.latitude},#{loc.longitude}]\n},\n"
    end
    @json << "]}"
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loc }
    end
  end

end
