#!/bin/bash

# get the EPOCH date
DATE=$(/bin/date +%s) 

#get to the right directory
cd /etc/enphase

#remove old csv
rm ENPHASE.csv
rm SOLAR.csv

#Get the data ready for a csv for MariaDB
RAW=$(lynx -dump http://ted6000/stats.htm | grep '(W)' | cut -d":" -f2 | awk '{print $2}') 

#make it Kw and put it in a file I can use for other things
/bin/echo "scale=3; $RAW/1000" | bc -l |sed 's/^/, /' | sed -e "s/^/$(date) /" >> ENPHASE.csv

#More MariaDB work
cat ENPHASE.csv | sed 's/[A-Za-z ]*//g' | cut -d"," -f2 >> SOLAR.csv
mysqlimport --local -u house --password=1qazxsw2 House --columns=KW SOLAR.csv

#Get the data into a variable
KW=$(cat ENPHASE.csv | sed 's/[A-Za-z ]*//g' | cut -d"," -f2)

##DEBUG
echo $KW >> debug.log
echo $DATE >> debug.log

#get data into rrd 
rrdtool update enphase.rrd $DATE:$KW

#create daily graph 
rrdtool graph /var/www/html/enphase/enphase_day.png -s -1day DEF:enphase=enphase.rrd:temp:AVERAGE LINE1:enphase#00CC00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 

#create weekly graph 
rrdtool graph /var/www/html/enphase/enphase_week.png -s -1week DEF:enphase=enphase.rrd:temp:AVERAGE LINE1:enphase#00CC00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 

#create monthly graph 
rrdtool graph /var/www/html/enphase/enphase_month.png -s -1month DEF:enphase=enphase.rrd:temp:AVERAGE LINE1:enphase#00CC00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 

#create yearly graph 
rrdtool graph /var/www/html/enphase/enphase_year.png -s -1year DEF:enphase=enphase.rrd:temp:AVERAGE LINE1:enphase#00CC00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 

#Kill any rrdtool running
killall -9 rrdtool
