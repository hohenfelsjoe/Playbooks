#!/bin/bash

# get the EPOCH date
DATE=$(/bin/date +%s)

#lets get in the right directory
cd /etc/ted/watts

#remove old csv
rm TED_DATA.csv
rm TED.csv

#Now we get the data we need and get it into a number
RAW=$(lynx -dump http://ted6000/stats.htm | grep '(W)' | cut -d":" -f2 | awk '{print $1}')

#make it Kw and put it in a file I can use for other things
/bin/echo "scale=3; $RAW/1000" | bc -l |sed 's/^/, /' | sed -e "s/^/$(date) /" >> TED_DATA.csv

#Get data into MariaDB
cat TED_DATA.csv | sed 's/[A-Za-z ]*//g' | cut -d"," -f2 >> TED.csv
mysqlimport --local -u house --password=1qazxsw2 House --columns=KW TED.csv

#make it a variable
KW=$(/bin/echo "scale=3; $RAW/1000" | bc -l)

#get data into rrd
rrdtool update ted_watts.rrd $DATE:$KW

#create daily graph
rrdtool graph /var/www/html/ted/ted_watts_day.png -s -1day DEF:ted_watts=ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#create weekly graph
rrdtool graph /var/www/html/ted/ted_watts_week.png -s -1week DEF:ted_watts=ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#create monthly graph
rrdtool graph /var/www/html/ted/ted_watts_month.png -s -1month DEF:ted_watts=ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#create yearly graph
rrdtool graph /var/www/html/ted/ted_watts_year.png -s -1year DEF:ted_watts=ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Kill any rrdtool running
killall -9 rrdtool
