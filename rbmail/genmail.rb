#!/usr/local/bin/ruby

require 'net/smtp'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

print 'How many mail?'
x = gets.strip.to_i

page = Nokogiri::HTML(open("http://loripsum.net/api/10/long/headers"))

for i in (1..x) do
message = <<MESSAGE_END
From: Fony<fon@example.com>
To: Bob <win@example.com>
Subject: Spam #  #{i}
#{page.text}
MESSAGE_END

#jfsaklfjewii123456789cvbnmkfsalssXJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34Xpfowejbdfasiiehrfnvlszxdosp1`0
   if i%2==0		
	Net::SMTP.start('10.10.6.92') do |smtp|
	  smtp.send_message message, 'fon@example.com',
	                             'win@example.com'
	end
   else
	Net::SMTP.start('10.10.6.93') do |smtp|
	  smtp.send_message message, 'fon@example.com', 
	                             'win@example.com'
	end
   end
end
