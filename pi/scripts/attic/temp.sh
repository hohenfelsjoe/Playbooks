#!/bin/bash

#make sure everything is mounted
mount -a

#Get in the correct directory
cd /etc/temperatures

#read the sensor
/usr/local/bin/AdafruitDHT.py 2302 4 > attic.txt

# get the EPOCH date
DATE=$(/bin/date +%s)

# get the temperature
TEMP=$(cat attic.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f2)

# get the humidity reading
HUMID=$(cat attic.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f3)

#Debug:
echo $TEMP >> debug.log
echo $HUMID >> debug.log

# Get Data in RRD
rrdtool update house_temp.rrd $DATE:$TEMP
rrdtool update attic_humid.rrd $DATE:$HUMID

# Create the Daily Graphs
rrdtool graph /etc/temperatures/house_temp_day.png -s -1day DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/attic_humid_day.png -s -1day DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/rm /mnt/share/Temperatures/house*.png
/bin/rm /mnt/share/Temperatures/attic*.png
/bin/cp /etc/temperatures/house_temp_day.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/attic_humid_day.png /mnt/share/Temperatures/

#create weekly graph
rrdtool graph /etc/temperatures/house_temp_week.png -s -1week DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/attic_humid_week.png -s -1week DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/house_temp_week.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/attic_humid_week.png /mnt/share/Temperatures/

#create monthly graph
rrdtool graph /etc/temperatures/house_temp_month.png -s -1month DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/attic_humid_month.png -s -1month DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/house_temp_month.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/attic_humid_month.png /mnt/share/Temperatures/

#create yearly graph
rrdtool graph /etc/temperatures/house_temp_year.png -s -1year DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/attic_humid_year.png -s -1year DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/house_temp_year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/attic_humid_year.png /mnt/share/Temperatures/

#create 2 year graph
rrdtool graph /etc/temperatures/house_temp_2year.png -s -2year DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/attic_humid_2year.png -s -2year DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/house_temp_2year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/attic_humid_2year.png /mnt/share/Temperatures/

#create 5 year graph
rrdtool graph /etc/temperatures/house_temp_5year.png -s -5year DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/attic_humid_5year.png -s -5year DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/house_temp_5year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/attic_humid_5year.png /mnt/share/Temperatures/

#Create the combined daily graph
rrdtool graph /etc/temperatures/local_combined_attic_day.png -s -1day DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#ff0000:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_attic_day.png /mnt/share/Temperatures/

#Create the combined weekly graph
rrdtool graph /etc/temperatures/local_combined_attic_week.png -s -1week DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#ff0000:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_attic_week.png /mnt/share/Temperatures/

#Create the combined monthly graph
rrdtool graph /etc/temperatures/local_combined_attic_month.png -s -1month DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#ff0000:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_attic_month.png /mnt/share/Temperatures/

#Create the combined yearly graph
rrdtool graph /etc/temperatures/local_combined_attic_year.png -s -1year DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#ff0000:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_attic_year.png /mnt/share/Temperatures/

#Create the combined 2 year graph
rrdtool graph /etc/temperatures/local_combined_attic_2year.png -s -2year DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#ff0000:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_attic_2year.png /mnt/share/Temperatures/

#Create the combined 5 year graph
rrdtool graph /etc/temperatures/local_combined_attic_5year.png -s -5year DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6:"Attic Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#ff0000:"Attic Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_attic_5year.png /mnt/share/Temperatures/

#Copy RRD to Share
#/bin/rm /mnt/share/Temperatures/house_temp.rrd
#/bin/cp house_temp.rrd /mnt/share/Temperatures/
/usr/bin/rrdtool dump house_temp.rrd house_temp.xml
/usr/bin/rrdtool dump attic_humid.rrd attic_humid.xml
/bin/rm /mnt/share/Temperatures/house_temp.rrd
/bin/rm /mnt/share/Temperatures/house_temp.xml
/bin/rm /mnt/share/Temperatures/attic_humid.rrd
/bin/rm /mnt/share/Temperatures/attic_humid.xml
/bin/cp house_temp.rrd /mnt/share/Temperatures/
/bin/cp house_temp.xml /mnt/share/Temperatures/
/bin/cp attic_humid.rrd /mnt/share/Temperatures/
/bin/cp attic_humid.xml /mnt/share/Temperatures/
