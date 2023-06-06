#!/bin/bash

#make sure everything is mounted
mount -a

#Get in the correct directory
cd /etc/temperatures

#read the sensor
/usr/local/bin/AdafruitDHT.py 2302 4 > bench.txt

# get the EPOCH date
DATE=$(/bin/date +%s)

# get the temperature
TEMP=$(cat bench.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f2)

# get the humidity reading
HUMID=$(cat bench.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f3)

#Debug:
echo $TEMP >> debug.log
echo $HUMID >> debug.log

# Get Data in RRD
rrdtool update bench_temp.rrd $DATE:$TEMP
rrdtool update bench_humid.rrd $DATE:$HUMID

# Create the Daily Graphs
rrdtool graph /etc/temperatures/armory_temp_day.png -s -1day DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/armory_humid_day.png -s -1day DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/armory_temp_day.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/armory_humid_day.png /mnt/share/Temperatures/

#create weekly graph
rrdtool graph /etc/temperatures/armory_temp_week.png -s -1week DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/armory_humid_week.png -s -1week DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/armory_temp_week.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/armory_humid_week.png /mnt/share/Temperatures/

#create monthly graph
rrdtool graph /etc/temperatures/armory_temp_month.png -s -1month DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/armory_humid_month.png -s -1month DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/armory_temp_month.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/armory_humid_month.png /mnt/share/Temperatures/

#create yearly graph
rrdtool graph /etc/temperatures/armory_temp_year.png -s -1year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/armory_humid_year.png -s -1year DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/armory_temp_year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/armory_humid_year.png /mnt/share/Temperatures/

#Create 2 Year graph
rrdtool graph /etc/temperatures/armory_temp_2year.png -s -2year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/armory_humid_2year.png -s -2year DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/armory_temp_2year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/armory_humid_2year.png /mnt/share/Temperatures/

#Create 5 Year graph
rrdtool graph /etc/temperatures/armory_temp_5year.png -s -5year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/armory_humid_5year.png -s -5year DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/armory_temp_5year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/armory_humid_5year.png /mnt/share/Temperatures/

#Create the combined daily graph
rrdtool graph /etc/temperatures/local_combined_armory_day.png -s -1day DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_armory_day.png /mnt/share/Temperatures/

#Create the combined weekly graph
rrdtool graph /etc/temperatures/local_combined_armory_week.png -s -1week DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_armory_week.png /mnt/share/Temperatures/

#Create the combined monthly graph
rrdtool graph /etc/temperatures/local_combined_armory_month.png -s -1month DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_armory_month.png /mnt/share/Temperatures/

#Create the combined yearly graph
rrdtool graph /etc/temperatures/local_combined_armory_year.png -s -1year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_armory_year.png /mnt/share/Temperatures/

#Create the combined 2 year graph
rrdtool graph /etc/temperatures/local_combined_armory_2year.png -s -2year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_armory_2year.png /mnt/share/Temperatures/

#Create the combined 5 year graph
rrdtool graph /etc/temperatures/local_combined_armory_5year.png -s -5year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#d27d2d -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_armory_5year.png /mnt/share/Temperatures/

#Copy RRD to Share
/usr/bin/rrdtool dump bench_temp.rrd bench_temp.xml
/usr/bin/rrdtool dump bench_humid.rrd bench_humid.xml
/bin/rm /mnt/share/Temperatures/bench_temp.rrd
/bin/rm /mnt/share/Temperatures/bench_temp.xml
/bin/rm /mnt/share/Temperatures/bench_humid.rrd
/bin/rm /mnt/share/Temperatures/bench_humid.xml
/bin/cp bench_temp.rrd /mnt/share/Temperatures/
/bin/cp bench_temp.xml /mnt/share/Temperatures/
/bin/cp bench_humid.rrd /mnt/share/Temperatures/
/bin/cp bench_humid.xml /mnt/share/Temperatures/
