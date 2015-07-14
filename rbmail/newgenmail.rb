#!/usr/local/bin/ruby

require 'net/smtp'
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'time'

print 'To whom? (just nickname)'
name = gets.strip
sender='fony@example.com'
rcpt = name+'@example.com'
subject = 'new generated text'
####

print 'How many mails??'
x = gets.strip.to_i

#page = Nokogiri::HTML(open("http://loripsum.net/api/10/long/headers"))

for i in (0..x) do


page = Nokogiri::HTML(open("http://randomtextgenerator.com"))


message = <<MESSAGE_END
From: Fony<#{sender}>
To: Kelvin<#{rcpt}>
Subject: #{subject} # #{i}
Date: #{Time.now.httpdate}
#{page.css('textarea#generatedtext')[0].text}
MESSAGE_END

#jfsaklfjewii123456789cvbnmkfsalssXJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34Xpfowejbdfasiiehrfnvlszxdosp1`0
   if i%2==0		
	Net::SMTP.start('10.10.6.92') do |smtp|
	  smtp.send_message message,sender,rcpt
	end
   else
	Net::SMTP.start('10.10.6.93') do |smtp|
	  smtp.send_message message,sender,rcpt
	end
   end
#print message
end
