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

    begin
      @task_logger.log "looking up location for #{@object.ip_address}"
      loc = @db.city(@object.ip_address)
      if loc
        @task_logger.log "adding location for #{@object.ip_address}"
        create_object(PhysicalLocation, { 
          :zip => loc.postal_code.force_encoding('UTF-8'),
          :city => loc.city_name.force_encoding('UTF-8'),
          :state => loc.region_name.force_encoding('UTF-8'),
          :country => loc.country_name.force_encoding('UTF-8'),
          :longitude => loc.longitude,
          :latitude => loc.latitude})
      end
    rescue ArgumentError => e
     @task_logger.log "Argument Error #{e}"
    rescue Encoding::InvalidByteSequenceError => e
     @task_logger.log "Encoding error: #{e}"
    rescue Encoding::UndefinedConversionError => e
     @task_logger.log "Encoding error: #{e}"
    
    end
  end
  
  def cleanup
    super
  end
