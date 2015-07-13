#!/usr/local/bin/ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
print 'Which page?'
x = gets.strip.to_i
if x<0
	y='001'
elsif x<10
	y="00#{x}"
elsif x<100
	y="0#{x}"
else
	y=x.to_s
end

puts y
page = Nokogiri::HTML(open("http://www.scp-wiki.net/scp-#{y}"))  
puts page.css('div#page-content')[0].text.to_s
