#!/bin/sh
rm dependenciesss
touch dependenciesss
while read p; do
	pkg info -d $p|awk '/\t/'| sed 's/-[0-9][0-9,.,_,a-z,:]*//g' >> dependenciesss
done <packagelist

awk '!a[$0]++' dependenciesss > dependencies

while read p; do
	pkg info -d $p|awk '/\t/' |sed 's/-[0-9][0-9,.,_,a-z,:]*//g' >> dependencies
	#awk '!a[$0]++' dependenciesss > dependencies
done <dependencies

echo '-------------'
awk '!a[$0]++' dependencies > dependency
echo '-- FINISH --'
rm dependenciesss

while read p; do
	pkg create $p
done <packagelist

while read p; do
	pkg create $p
done <dependency

pkg repo .
