#!/usr/local/bin/ruby

require 'net/smtp'
require 'time'

sender='fon@example.com'
rcpt='gun@example.com'
subject='This is Subject'

########################

print 'How many mail?'
x = gets.strip.to_i

for i in (1..x) do
message = <<MESSAGE_END
From: Fony<#{sender}>
To: Bob <#{rcpt}>
Subject: #{subject} #  #{i}
Date: #{Time.now.httpdate}
Special Containment Procedures: SCP-053 is to be contained in an area no less than 5 m x 5 m (16 ft x 16 ft) and given adequate room to move. Toys, books, games, and other recreational devices are to be amply provided and rotated every three (3) months. Proper bedding, bathroom, and medical facilities are to be maintained at all times. Food should be provided three (3) times daily, and two (2) snacks are allowed if requested.

No physical contact is to be made with SCP-053 without full atmosphere-containment suit and eye shield. No eye contact is to be made with SCP-053 for any reason. Any objects given to personnel by SCP-053 may be removed, but must be given to quarantine for examination. Only one (1) member of personnel may be present in the room at any given time and must be secured by a safety line of steel cable. All personnel must be removed from SCP-053's containment chamber within 10 minutes of entering.

Any personnel who begin to act erratically, scream, or attempt to grab SCP-053 are to be removed and quarantined. Any personnel attempting to remove their suit are also to be removed and quarantined. No sharp objects or firearms are allowed in SCP-053's containment room.

Description: SCP-053 appears to be a small 3-year-old girl. She is capable of basic speech and appears to be slightly above average in mental development. She has a generally pleasant personality and rarely seems upset, becoming agitated only in the presence of groups of people.

Any and all humans over the age of three who make eye contact with, physically touch, or remain around SCP-053 for longer than 10 minutes will rapidly become irrational, paranoid, and homicidal. Most, if not all, of these feelings will be directed at SCP-053, and afflicted subjects will attempt to kill SCP-053 after first killing or driving off all humans visible to them. Those attempting to kill SCP-053 will suffer massive heart attacks or seizures and die seconds after doing any physical damage to SCP-053. SCP-053 will regenerate almost instantaneously from any wound, regardless of severity.

SCP-053 appears wholly ignorant of these effects, and ignores any and all subjects affected. When questioned about the effect, SCP-053 is incapable of response.
MESSAGE_END

#jfsaklfjewii123456789cvbnmkfsalssXJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34Xpfowejbdfasiiehrfnvlszxdosp1`0
   if i%2==0		
	Net::SMTP.start('10.10.6.92') do |smtp|
	  smtp.send_message message, sender,rcpt
	end
   else
	Net::SMTP.start('10.10.6.93') do |smtp|
	  smtp.send_message message,sender,rcpt
	end
   end
end
