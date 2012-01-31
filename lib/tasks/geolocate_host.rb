require 'geoip'
require 'iconv'

  def name
    "geolocate_host"
  end

  def description
    "Performs a geolocation lookup based on an ip address"
  end

  def allowed_types
    return [Host]
  end

  def setup(object, options={})
    super(object, options)
    @db = GeoIP.new(File.join(Rails.root, 'data', 'geolitecity', 'latest.dat'))
    self
  end
  
  def run
    super

    loc = @db.city(@object.ip_address)
  
    ## Handle weird characters
    if loc
      count = 0
      loc.each  do |value| 
        if value.kind_of? String
          loc[count] = ::Iconv.conv('UTF-8//IGNORE', 'UTF-8', loc[count]).to_s
        end
        count = count + 1
      end

      loc.each {|x| puts x}

      location = create_object(PhysicalLocation, { 
        :zip => loc.postal_code,
        :city => loc.city_name,
        :state => loc.region_name,
        :country => loc.country_name,
        :longitude => loc.longitude,
        :latitude => loc.latitude})

    end
  end
  
  def cleanup
    super
  end
