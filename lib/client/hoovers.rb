require 'open-uri'
require 'cgi'

module Ear
module Client
module HooverScraper

# This class represents the Hoovers API
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
    search_string = CGI.escapeHTML search_string
    search_string.gsub!(" ", "&nbsp;")
  
  end
end

# This class represents a search result. 
class SearchResult

  attr_accessor :title

  def initialize
  end

  # 
  #  Takes: A JSON search result
  #
  #  Returns: Nothing
  #
  def parse_xml(result)
    @title = result['title']
  end
end

end
end
end
