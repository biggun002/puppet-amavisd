#!/usr/local/bin/ruby

require 'mail'

print 'How many mail?'
x = gets.strip.to_i

for i in (1..x) do
	#Mail.defaults do
  	#	delivery_method :smtp, address: "example.com", port: 25
	#end
	
	#Mail.deliver do
	mail = Mail.new do
	  from    'fon@example.com'
	  to      'win@example.com'
	  subject "Test Mail #{i}"
	  body    File.read('body.txt')
	end
	#mail.delivery_method :sendmail, address: "example.com", port:25
	#mail.deliver	
	mail.deliver!
end
