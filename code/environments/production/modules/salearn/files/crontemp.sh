host='example.com'
#for real user #
#
#cat /etc/passwd | grep /home | cut -d: -f1  > users
mysql -e "use postfix; select username from mailbox" > users
sed -i '' -e '1,1d' users

rm tempcron

while read p; do
  local_part=$(echo $p|cut -d '@' -f1)
  domain=$(echo $p|cut -d '@' -f2)
  
  #-- Virtual User --
  #echo $p@$host $p >> /usr/local/etc/postfix/virtual
  #touch /home/$p/user_prefs
  
  #get old crontab content
  #crontab -u $p -l > tempcron
  
  echo '#sa-learn: '$local_part'@'$domain >> tempcron
  echo '*/10 * * * *          /usr/local/bin/sa-learn --spam /usr/local/virtual/'$domain'/'$local_part'/.Spam/{cur,new} > /dev/null 2>&1'>> tempcron
  echo '*/10 * * * *          /usr/local/bin/sa-learn --ham /usr/local/virtual/'$domain'/'$local_part'/{cur,new} > /dev/null 2>&1'>> tempcron
  #crontab -u $p tempcron
  crontab -u vscan tempcron
done <users
#postmap /usr/local/etc/postfix/virtual
#rm users
