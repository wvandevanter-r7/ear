$:.unshift(File.dirname(__FILE__))

require '../../../config/environment'
require 'test/unit'

class TestGoogleSearchScraper < Test::Unit::TestCase

  def test_google_search_scraper_test
    scraper = Ear::Client::Google::SearchScraper.new  
    results = scraper.search("test")
    assert results.count == 10,"Wrong count, should be 10, is #{results.count}"  
  end

end
