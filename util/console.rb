#!/usr/bin/env ruby
require 'pry'
require "#{File.expand_path(File.dirname(__FILE__))}/../config/environment"

Pry.start(self, :prompt => [proc{"ear>"}])
