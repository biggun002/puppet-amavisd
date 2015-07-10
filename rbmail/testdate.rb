#!/usr/local/bin/ruby
require 'time'
#require 'rubyrail'
puts Time.zone
Time.zone = 'ICT'
puts Time.zone
#Date: Sat, 23 Jun 2001 16:26:43 +0900
puts Time.zone.now.httpdate
#puts Date.today.in_time_zone
puts Time.now.httpdate
