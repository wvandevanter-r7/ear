require 'open-uri'
require 'nokogiri'
  
module Ear
module Client
module TwitPic

  # This class represents the corpwatch service
  class TwitPicScraper

    def initialize
    
    end

    # 
    # Takes: Nothing
    # 
    # Ruturns: An array of corpwatch corps from the search 
    #
    def search_by_user(username, pages=4)
      # Convert to a get-paramenter
      username = CGI.escapeHTML username
      username.gsub!(" ", "&nbsp;")
    
      # initialize an array of corps to return 
      pics = []


      #@task_logger.log "Using Company URI: #{uri}"
      search_uri = "http://twitpic.com/photos/#{username}"

      # Open page & parse
      doc = Nokogiri::HTML(open(search_uri, {"User-Agent" => EAR::USER_AGENT_STRING})) do |config|
        config.noblanks
      end

      # for each thumbnail
      doc.xpath("//*[@id=\"photo-container\"]/div/div/a/@href").each do |path|

        # grab the full pic - TODO - is this necessary?
        image_link = "http://twitpic.com/#{path}"

        # grabe the page
        doc = Nokogiri::HTML(open(image_link, {"User-Agent" => EAR::USER_AGENT_STRING})) do |config|
           config.noblanks
        end

        # open up each image's page & create a new twitpic. don't download by default
        p = TwitPicture.new(doc.xpath("//*[@id=\"media\"]/img/@src").to_s)

        pics << p if p

      end
    pics
    end

  end

  # This class represents a corporation as returned by the Corpwatch service. 
  class TwitPicture
    attr_accessor :remote_path
    attr_accessor :local_path

    def initialize(link, do_download=true)
          # grab the image & store locally
          @remote_path = link
          @local_path = "/tmp/twitpic_file_#{rand(1000000)}"
          download_remote_file if do_download
    end

    def download_remote_file
      begin
        open(@local_path, "wb") do |file|
          file.write open(@remote_path).read
        end
      rescue Exception => e
        puts "#{e}"
        return false
      end
      true
    end

  end
end
end
end
