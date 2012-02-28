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
        display << "<a href=\"#{request.url}/../../#{x.underscore}s/#{x.id}\">#{x.to_s}</a><br/>"
        
        x.children.each do |y|
            display << "<a href=\"#{request.url}/../../#{y.underscore}s/#{y.id}\">#{y.to_s}</a><br/>"
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
