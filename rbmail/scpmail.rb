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

####

print 'Start Chapter?'
a = gets.strip.to_i
print 'End Chapter?'
x = gets.strip.to_i

#page = Nokogiri::HTML(open("http://loripsum.net/api/10/long/headers"))

for i in (a..x) do

#SCP part
if i<0
	y='001'
elsif i<10
	y="00#{i}"
elsif i<100
	y="0#{i}"
else
	y=i.to_s
end

#THAI-notworking
#page = Nokogiri::HTML(open("http://scp-th.wikidot.com/scp-#{y}"))  
#ENG
page = Nokogiri::HTML(open("http://www.scp-wiki.net/scp-#{y}"))  
#end SCP part


message = <<MESSAGE_END
From: Fony<#{sender}>
To: Kelvin<#{rcpt}>
Subject: SCP-#{y}
Date: #{Time.now.httpdate}
#{page.css('div#page-content')[0].text}
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
end
