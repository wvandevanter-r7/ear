require 'yaml'
require 'singleton'

module Ear
  class ApiKeys
    include Singleton
    attr_accessor :keys
  
    def initialize
      # Load in all known api keys
      @keys = YAML.load_file(File.join(File.dirname(__FILE__),"..","..","config","ear_api_keys.yml"))
    end
  end
end

Ear::ApiKeys.instance
