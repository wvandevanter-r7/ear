$:.unshift(File.dirname(__FILE__))

require '../../../config/environment'
require 'test/unit'

class TestBing < Test::Unit::TestCase

  def test_bing_search_acme
    x = Ear::Client::Bing::SearchService.new
    results = x.search "acme"
    assert results.count == 40, "Wrong count, should be 8, is #{results.count}"
  end

  def test_bing_search_test
    x = Ear::Client::Bing::SearchService.new
    results = x.search "test"
    assert results.count == 38, "Wrong count, should be 8, is #{results.count}"
  end

  def test_bing_ip_search_whitehouse_dot_gov
    x = Ear::Client::Bing::SearchService.new
    results = x.search "ip:184.25.196.110"
    assert results.count == 0
  end

  def test_bing_ip_search_test_dot_com
    x = Ear::Client::Bing::SearchService.new
    results = x.search "ip:216.27.85.170"
    assert results.count == 2, "Wrong count, should be 2, is #{results.count}"
    assert results.first.display_url == "www.test.com", 
      "display url was: #{results.first.display_url}, expected www.test.com" 
  end

end
