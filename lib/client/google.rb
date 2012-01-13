require 'open-uri'

module Ear
module Client
module Google

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

# This class represents a corporation as returned by the Corpwatch service. 
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
end

end
end
end
