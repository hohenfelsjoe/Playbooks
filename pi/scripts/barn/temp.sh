#!/bin/bash

#make sure everything is mounted
mount -a

#Get in the correct directory
cd /etc/temperatures

#read the sensor
python3 /usr/local/bin/AdafruitDHT.py 2302 4 > barn.txt

# get the EPOCH date
DATE=$(/bin/date +%s)

# get the temperature
TEMP=$(cat barn.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f2)

# get the humidity reading
HUMID=$(cat barn.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f3)

#Debug:
echo $TEMP >> debug.log
echo $HUMID >> debug.log

# Get Data in RRD
rrdtool update barn_temp.rrd $DATE:$TEMP
rrdtool update barn_humid.rrd $DATE:$HUMID

# Create the Daily Graphs
rrdtool graph /etc/temperatures/barn_temp_day.png -s -1day DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
rrdtool graph /etc/temperatures/barn_humid_day.png -s -1day DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/barn_temp_day.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/barn_humid_day.png /mnt/share/Temperatures/

#create weekly graph
rrdtool graph /etc/temperatures/barn_temp_week.png -s -1week DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/barn_humid_week.png -s -1week DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/barn_temp_week.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/barn_humid_week.png /mnt/share/Temperatures/

#create monthly graph
rrdtool graph /etc/temperatures/barn_temp_month.png -s -1month DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/barn_humid_month.png -s -1month DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/barn_temp_month.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/barn_humid_month.png /mnt/share/Temperatures/

#create yearly graph
rrdtool graph /etc/temperatures/barn_temp_year.png -s -1year DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/barn_humid_year.png -s -1year DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/barn_temp_year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/barn_humid_year.png /mnt/share/Temperatures/

#Create 2 Year graph
rrdtool graph /etc/temperatures/barn_temp_2year.png -s -2year DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/barn_humid_2year.png -s -2year DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/barn_temp_2year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/barn_humid_2year.png /mnt/share/Temperatures/

#Create 5 Year graph
rrdtool graph /etc/temperatures/barn_temp_5year.png -s -5year DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
rrdtool graph /etc/temperatures/barn_humid_5year.png -s -5year DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa 
/bin/cp /etc/temperatures/barn_temp_5year.png /mnt/share/Temperatures/
/bin/cp /etc/temperatures/barn_humid_5year.png /mnt/share/Temperatures/

#Create the combined daily graph
rrdtool graph /etc/temperatures/local_combined_barn_day.png -s -1day DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_barn_day.png /mnt/share/Temperatures/

#Create the combined weekly graph
rrdtool graph /etc/temperatures/local_combined_barn_week.png -s -1week DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_barn_week.png /mnt/share/Temperatures/

#Create the combined monthly graph
rrdtool graph /etc/temperatures/local_combined_barn_month.png -s -1month DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_barn_month.png /mnt/share/Temperatures/

#Create the combined yearly graph
rrdtool graph /etc/temperatures/local_combined_barn_1year.png -s -1year DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#4d2600:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_barn_1year.png /mnt/share/Temperatures/

#Create the combined 2year graph
rrdtool graph /etc/temperatures/local_combined_barn_2year.png -s -2year DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#4d2600:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_barn_2year.png /mnt/share/Temperatures/

#Create the combined 5year graph
rrdtool graph /etc/temperatures/local_combined_barn_5year.png -s -5year DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#4d2600:"Shop Temp" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000:"Shop Humidity" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa
/bin/cp /etc/temperatures/local_combined_barn_5year.png /mnt/share/Temperatures/

#Copy RRD to Share
/usr/bin/rrdtool dump barn_temp.rrd barn_temp.xml
/usr/bin/rrdtool dump barn_humid.rrd barn_humid.xml
/bin/rm /mnt/share/Temperatures/barn_temp.rrd
/bin/rm /mnt/share/Temperatures/barn_temp.xml
/bin/rm /mnt/share/Temperatures/barn_humid.rrd
/bin/rm /mnt/share/Temperatures/barn_humid.xml
/bin/cp barn_temp.rrd /mnt/share/Temperatures/
/bin/cp barn_temp.xml /mnt/share/Temperatures/
/bin/cp barn_humid.rrd /mnt/share/Temperatures/
/bin/cp barn_humid.xml /mnt/share/Temperatures/
