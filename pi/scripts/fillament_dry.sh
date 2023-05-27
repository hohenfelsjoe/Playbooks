#!/bin/bash

#make sure everything is mounted
mount -a

#Get in the correct directory
cd /etc/filament

#read the sensor
/usr/local/bin/AdafruitDHT.py 2302 4 > dryer.txt

# get the EPOCH date
DATE=$(/bin/date +%s)

# get the temperature
TEMP=$(cat dryer.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f2)

# get the humidity reading
HUMID=$(cat dryer.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f3)

#Debug:
echo $TEMP >> debug.log
echo $HUMID >> debug.log

# Get Data in RRD
rrdtool update dryer_temp.rrd $DATE:$TEMP
rrdtool update dryer_humid.rrd $DATE:$HUMID

# Create the Daily Graphs
rrdtool graph /etc/filament/dryer_temp_day.png -s -1day DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/filament/dryer_humid_day.png -s -1day DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/filament/dryer_temp_day.png /mnt/share/temperatures/
/bin/cp /etc/filament/dryer_humid_day.png /mnt/share/temperatures/

#create weekly graph
rrdtool graph /etc/filament/dryer_temp_week.png -s -1week DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/filament/dryer_humid_week.png -s -1week DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/filament/dryer_temp_week.png /mnt/share/temperatures/
/bin/cp /etc/filament/dryer_humid_week.png /mnt/share/temperatures/

#create monthly graph
rrdtool graph /etc/filament/dryer_temp_month.png -s -1month DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/filament/dryer_humid_month.png -s -1month DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/filament/dryer_temp_month.png /mnt/share/temperatures/
/bin/cp /etc/filament/dryer_humid_month.png /mnt/share/temperatures/

#create yearly graph
rrdtool graph /etc/filament/dryer_temp_year.png -s -1year DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/filament/dryer_humid_year.png -s -1year DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/filament/dryer_temp_year.png /mnt/share/temperatures/
/bin/cp /etc/filament/dryer_humid_year.png /mnt/share/temperatures/

#Create 2 Year graph
rrdtool graph /etc/filament/dryer_temp_2year.png -s -2year DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/filament/dryer_humid_2year.png -s -2year DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/filament/dryer_temp_2year.png /mnt/share/temperatures/
/bin/cp /etc/filament/dryer_humid_2year.png /mnt/share/temperatures/

#Create 5 Year graph
rrdtool graph /etc/filament/dryer_temp_5year.png -s -5year DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/filament/dryer_humid_5year.png -s -5year DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/filament/dryer_temp_5year.png /mnt/share/temperatures/
/bin/cp /etc/filament/dryer_humid_5year.png /mnt/share/temperatures/

#Create the combined daily graph
rrdtool graph /etc/filament/local_combine_dryer_day.png -s -1day DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/filament/local_combine_dryer_day.png /mnt/share/temperatures/

#Create the combined weekly graph
rrdtool graph /etc/filament/local_combine_dryer_week.png -s -1week DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/filament/local_combine_dryer_week.png /mnt/share/temperatures/

#Create the combined monthly graph
rrdtool graph /etc/filament/local_combine_dryer_month.png -s -1month DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/filament/local_combine_dryer_month.png /mnt/share/temperatures/

#Create the combined yearly graph
rrdtool graph /etc/filament/local_combine_dryer_year.png -s -1year DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/filament/local_combine_dryer_year.png /mnt/share/temperatures/

#Create the combined 2 year graph
rrdtool graph /etc/filament/local_combine_dryer_2year.png -s -2year DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/filament/local_combine_dryer_2year.png /mnt/share/temperatures/

#Create the combined 5 year graph
rrdtool graph /etc/filament/local_combine_dryer_5year.png -s -5year DEF:dryer_temp=dryer_temp.rrd:temp:AVERAGE LINE1:dryer_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:dryer_humid=dryer_humid.rrd:temp:AVERAGE LINE1:dryer_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/filament/local_combine_dryer_5year.png /mnt/share/temperatures/

#Copy RRD to Share
/usr/bin/rrdtool dump dryer_temp.rrd dryer_temp.xml
/usr/bin/rrdtool dump dryer_humid.rrd dryer_humid.xml
/bin/rm /mnt/share/temperatures/dryer_temp.rrd
/bin/rm /mnt/share/temperatures/dryer_temp.xml
/bin/rm /mnt/share/temperatures/dryer_humid.rrd
/bin/rm /mnt/share/temperatures/dryer_humid.xml
/bin/cp dryer_temp.rrd /mnt/share/temperatures/
/bin/cp dryer_temp.xml /mnt/share/temperatures/
/bin/cp dryer_humid.rrd /mnt/share/temperatures/
/bin/cp dryer_humid.xml /mnt/share/temperatures/
