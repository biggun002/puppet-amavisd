#!/usr/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(open("http://loripsum.net/api/10/long/headers"))  
puts page.text.to_s
