class MapsController < ApplicationController
  # GET /maps/google_default
  # GET /maps/google_default.json
  def google_default
    @loc = PhysicalLocation.all
    
    #f = File.open("#{File.dirname(__FILE__)}/../../public/listing.js","w")
    @json =  "var sweetObj = {\'locations\': ["

    @loc.each do |loc|
      display  = ""
      
      loc.parents.each do |x|
      
        if x.class == Host
          display = x.to_s
        else
          display = x.to_s
        end
        
        x.children.each do |y|
          display << " / " << y.to_s
        end
      end
      
      @json << "{\n\'name\': \'#{display}\',\n\'position\': [#{loc.latitude},#{loc.longitude}]\n},\n"
    end

    @json << "]}"
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @json }
    end
  end

  def index
    # query a list of all maps
  end

end
