#! /bin/sh

#get into /tmp
cd /tmp

#Clean up
rm -f *.csv

# get the EPOCH date
DATE=$(/bin/date +%s)

#Get the raw data
python3 /usr/bin/speedtest-cli --simple --secure > /tmp/speedtest-rrd.txt

#Clean it up and get raw Ping time in ms
RAW_MS=$(cat /tmp/speedtest-rrd.txt | grep P | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"m" -f1)

#Get it into MariaDB
cat /tmp/speedtest-rrd.txt | grep P | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"m" -f1 >> PING.csv
mysqlimport --local -u house --password=1qazxsw2 "Speed Test" --columns=MS PING.csv

#Clean it up and get raw Download time in MiB
RAW_DL=$(cat /tmp/speedtest-rrd.txt | grep D | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1)

#Get it into MariaDB
cat /tmp/speedtest-rrd.txt | grep D | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1 >> DOWN.csv
mysqlimport --local -u house --password=1qazxsw2 "Speed Test" --columns=DOWN DOWN.csv

#Clean it up and get raw Upload time in MiB
RAW_UP=$(cat /tmp/speedtest-rrd.txt | grep U | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1)

#Get it into MariaDB
cat /tmp/speedtest-rrd.txt | grep U | sed -r 's/\s+//g'| cut -d":" -f2 | cut -d"M" -f1 >> UP.csv
mysqlimport --local -u house --password=1qazxsw2 "Speed Test" --columns=UP UP.csv

#get data into rrd
cd /etc/speedtest/
rrdtool update speedtest_ms.rrd $DATE:$RAW_MS
rrdtool update speedtest_dl.rrd $DATE:$RAW_DL
rrdtool update speedtest_up.rrd $DATE:$RAW_UP

#create the daily graphs
#Ping Time
rrdtool graph /var/www/html/speedtest/speedtest_ms_day.png -s -1day DEF:speedtest_ms=speedtest_ms.rrd:temp:AVERAGE LINE1:speedtest_ms#FF0000:"Ping Time" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 

#Download Speed
rrdtool graph /var/www/html/speedtest/speedtest_dl_day.png -s -1day DEF:speedtest_dl=speedtest_dl.rrd:temp:AVERAGE LINE1:speedtest_dl#0000FF:"Download Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Upload Speed
rrdtool graph /var/www/html/speedtest/speedtest_up_day.png -s -1day DEF:speedtest_up=speedtest_up.rrd:temp:AVERAGE LINE1:speedtest_up#00FF00:"Upload Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#create the weekly graphs
#Ping Time
rrdtool graph /var/www/html/speedtest/speedtest_ms_week.png -s -1week DEF:speedtest_ms=speedtest_ms.rrd:temp:AVERAGE LINE1:speedtest_ms#FF0000:"Ping Time" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Download Speed
rrdtool graph /var/www/html/speedtest/speedtest_dl_week.png -s -1week DEF:speedtest_dl=speedtest_dl.rrd:temp:AVERAGE LINE1:speedtest_dl#0000FF:"Download Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Upload Speed
rrdtool graph /var/www/html/speedtest/speedtest_up_week.png -s -1week DEF:speedtest_up=speedtest_up.rrd:temp:AVERAGE LINE1:speedtest_up#00FF00:"Upload Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#create the monthly graphs
#Ping Time
rrdtool graph /var/www/html/speedtest/speedtest_ms_month.png -s -1month DEF:speedtest_ms=speedtest_ms.rrd:temp:AVERAGE LINE1:speedtest_ms#FF0000:"Ping Time" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Download Speed
rrdtool graph /var/www/html/speedtest/speedtest_dl_month.png -s -1month DEF:speedtest_dl=speedtest_dl.rrd:temp:AVERAGE LINE1:speedtest_dl#0000FF:"Download Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Upload Speed
rrdtool graph /var/www/html/speedtest/speedtest_up_month.png -s -1month DEF:speedtest_up=speedtest_up.rrd:temp:AVERAGE LINE1:speedtest_up#00FF00:"Upload Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#create the yearly graphs
#Ping Time
rrdtool graph /var/www/html/speedtest/speedtest_ms_year.png -s -1year DEF:speedtest_ms=speedtest_ms.rrd:temp:AVERAGE LINE1:speedtest_ms#FF0000:"Ping Time" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Download Speed
rrdtool graph /var/www/html/speedtest/speedtest_dl_year.png -s -1year DEF:speedtest_dl=speedtest_dl.rrd:temp:AVERAGE LINE1:speedtest_dl#0000FF:"Download Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Upload Speed
rrdtool graph /var/www/html/speedtest/speedtest_up_year.png -s -1year DEF:speedtest_up=speedtest_up.rrd:temp:AVERAGE LINE1:speedtest_up#00FF00:"Upload Speed" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Clean up
rm /tmp/speedtest-rrd.txt
killall -9 rrdtool
