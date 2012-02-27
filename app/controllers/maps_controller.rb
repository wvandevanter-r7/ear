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
        if x.kind_of? Host
          display = "<a href=\"#{request.url}/../../hosts/#{x.id}\">#{x.to_s}</a><br/>"
        elsif x.kind_of? Domain
          display = "<a href=\"#{request.url}/../../domains/#{x.id}\">#{x.to_s}</a><br/>"
        elsif x.kind_of? PhysicalLocation
          display = "<a href=\"#{request.url}/../../physical_locations/#{x.id}\">#{x.to_s}</a><br/>"
        else
          display = x.to_s
        end
        
        x.children.each do |y|
          if y.kind_of? Host
            display << "<a href=\"#{request.url}/../../hosts/#{y.id}\">#{y.to_s}</a><br/>"
          elsif y.kind_of? Domain
            display << "<a href=\"#{request.url}/../../domains/#{y.id}\">#{y.to_s}</a><br/>"
          elsif y.kind_of? PhysicalLocation
            display << "<a href=\"#{request.url}/../../physical_locations/#{y.id}\">#{y.to_s}</a><br/>"
          else
            display << y.to_s
          end
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
