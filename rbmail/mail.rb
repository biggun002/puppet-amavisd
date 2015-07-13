#!/usr/local/bin/ruby

require 'net/smtp'

print 'How many mail?'
x = gets.strip.to_i

for i in (1..x) do
message = <<MESSAGE_END
From: Fony<fon@example.com>
To: Bob <win@example.com>
Subject: You win the lottery, Money to you  #{i}
Contulations, free iPhone call me if you can
MESSAGE_END

#jfsaklfjewii123456789cvbnmkfsalssXJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34Xpfowejbdfasiiehrfnvlszxdosp1`0
   if i%2==0		
	Net::SMTP.start('10.10.6.92') do |smtp|
	  smtp.send_message message, 'fon@example.com',
	                             'gun@example.com'
	end
   else
	Net::SMTP.start('10.10.6.93') do |smtp|
	  smtp.send_message message, 'fon@example.com', 
	                             'gun@example.com'
	end
   end
end
