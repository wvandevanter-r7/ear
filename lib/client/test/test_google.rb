$:.unshift(File.dirname(__FILE__))

require '../../../config/environment'
#require '../google'
require 'test/unit'

class TestGoogle < Test::Unit::TestCase

  def test_google_search_acme
    x = Ear::Client::Google::SearchService.new
    results = x.search "acme"
    assert results.count == 8, "Wrong count, should be 8, is #{results.count}"
  end

  def test_google_search_test
    x = Ear::Client::Google::SearchService.new
    results = x.search "test"
    assert results.count == 8, "Wrong count, should be 8, is #{results.count}"
  end

end
