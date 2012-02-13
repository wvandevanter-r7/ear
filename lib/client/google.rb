require 'open-uri'
require 'cgi'
require "capybara"  
require "capybara/dsl"  
require "capybara-webkit"  

module Ear
module Client
module Google

############################  
# DEPENDENCIES:  
#  
# Install the capybara gem:  
# $ gem install capybara  
#  
# Then, follow instructions from https://github.com/thoughtbot/capybara-webkit#readme   
# and install the capybara-webkit gem and drivers:  
# $ sudo apt-get install libqt4-dev libqtwebkit-dev  
# $ gem install capybara-webkit  
############################  

class SearchScraper
  include Capybara::DSL  
    
    def initialize
      Capybara.run_server = false
      Capybara.default_selector = :xpath
      Capybara.current_driver = :webkit
      Capybara.app_host = "http://www.google.com/"
    end
    
    def search(term)
      uris = []
      visit('/')
      fill_in "q", :with => term  
      click_button "Google Search"
      results = all("//li[@class='g']/h3/a")
      results.each { |r| uris << r[:href]}
    uris
    end
end

# This class represents the google AJAX API
# 
# Reference: 
# * http://chris.mowforth.com/google-ajax-search-api-ruby-0
#
class SearchService

  def initialize
  end

  # 
  # Takes: a search string
  # 
  # Ruturns: An array of search results 
  #
  def search(search_string)

    # Convert to a get-paramenter
    #search_string = CGI.escapeHTML search_string
    search_string.gsub!(" ", "&nbsp;")

    results = []

    #@task_logger.log "Using Company URI: #{uri}"
    api_path = "http://ajax.googleapis.com/ajax/services/search/web"
    search_data = "?v=1.0&key=#{Ear::ApiKeys.instance.keys['google_api_key']}&q=#{search_string}&rsz=large"
    response = open(api_path + search_data, 
      "User-Agent" => "EAR",
      "Referer" => "http://www.pentestify.com")
      
    JSON.parse(response.string)['responseData']['results'].each do |result| 
      s = SearchResult.new
      s.parse_json(result)
      results << s
    end
    
    return results
  end
end

# This class represents a searchresult. 
class SearchResult

  attr_accessor :gsearch_result_class
  attr_accessor :unescaped_url
  attr_accessor :url
  attr_accessor :visible_url
  attr_accessor :cached_url
  attr_accessor :title
  attr_accessor :title_no_formatting
  attr_accessor :content

  def initialize
  end

  # 
  #  Takes: A JSON search result
  #
  #  Returns: Nothing
  #
  def parse_json(result)
    @gsearch_result_class = result['GsearchResultClass']
    @unescaped_url = result['unescapedUrl']
    @url = result['url']
    @visible_url = result['visibleUrl']
    @cached_url = result['cacheUrl']
    @title = result['title']
    @title_no_formatting = result['titleNoFormatting'] 
    @content = result['content']
  end
  
  def to_s
    "#{@gsearch_result_class} #{@title} #{@url} #{@content}"
  end

end

end
end
end
