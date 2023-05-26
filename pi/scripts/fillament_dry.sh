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
rrdtool update ammo_temp.rrd $DATE:$TEMP
rrdtool update ammo_humid.rrd $DATE:$HUMID

# Create the Daily Graphs
rrdtool graph /etc/temperatures/ammo_temp_day.png -s -1day DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/ammo_humid_day.png -s -1day DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/ammo_temp_day.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/ammo_humid_day.png /mnt/share/Temperatures/

#create weekly graph
rrdtool graph /etc/temperatures/ammo_temp_week.png -s -1week DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/ammo_humid_week.png -s -1week DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/ammo_temp_week.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/ammo_humid_week.png /mnt/share/Temperatures/

#create monthly graph
rrdtool graph /etc/temperatures/ammo_temp_month.png -s -1month DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/ammo_humid_month.png -s -1month DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/ammo_temp_month.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/ammo_humid_month.png /mnt/share/Temperatures/

#create yearly graph
rrdtool graph /etc/temperatures/ammo_temp_year.png -s -1year DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/ammo_humid_year.png -s -1year DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/ammo_temp_year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/ammo_humid_year.png /mnt/share/Temperatures/

#Create 2 Year graph
rrdtool graph /etc/temperatures/ammo_temp_2year.png -s -2year DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/ammo_humid_2year.png -s -2year DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/ammo_temp_2year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/ammo_humid_2year.png /mnt/share/Temperatures/

#Create 5 Year graph
rrdtool graph /etc/temperatures/ammo_temp_5year.png -s -5year DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/ammo_humid_5year.png -s -5year DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/ammo_temp_5year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/ammo_humid_5year.png /mnt/share/Temperatures/

#Create the combined daily graph
rrdtool graph /etc/temperatures/local_combine_ammo_day.png -s -1day DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combine_ammo_day.png /mnt/share/Temperatures/

#Create the combined weekly graph
rrdtool graph /etc/temperatures/local_combine_ammo_week.png -s -1week DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combine_ammo_week.png /mnt/share/Temperatures/

#Create the combined monthly graph
rrdtool graph /etc/temperatures/local_combine_ammo_month.png -s -1month DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combine_ammo_month.png /mnt/share/Temperatures/

#Create the combined yearly graph
rrdtool graph /etc/temperatures/local_combine_ammo_year.png -s -1year DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combine_ammo_year.png /mnt/share/Temperatures/

#Create the combined 2 year graph
rrdtool graph /etc/temperatures/local_combine_ammo_2year.png -s -2year DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combine_ammo_2year.png /mnt/share/Temperatures/

#Create the combined 5 year graph
rrdtool graph /etc/temperatures/local_combine_ammo_5year.png -s -5year DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combine_ammo_5year.png /mnt/share/Temperatures/

#Copy RRD to Share
/usr/bin/rrdtool dump ammo_temp.rrd ammo_temp.xml
/usr/bin/rrdtool dump ammo_humid.rrd ammo_humid.xml
/bin/rm /mnt/share/Temperatures/ammo_temp.rrd
/bin/rm /mnt/share/Temperatures/ammo_temp.xml
/bin/rm /mnt/share/Temperatures/ammo_humid.rrd
/bin/rm /mnt/share/Temperatures/ammo_humid.xml
/bin/cp ammo_temp.rrd /mnt/share/Temperatures/
/bin/cp ammo_temp.xml /mnt/share/Temperatures/
/bin/cp ammo_humid.rrd /mnt/share/Temperatures/
/bin/cp ammo_humid.xml /mnt/share/Temperatures/
