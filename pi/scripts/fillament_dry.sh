#!/bin/bash

#make sure everything is mounted
mount -a

#Get in the correct directory
cd /etc/filament

#read the inside sensor
/usr/local/bin/AdafruitDHT.py 2302 4 > dryer_in.txt

#read the outside sensor
/usr/local/bin/AdafruitDHT.py 2302 21 > dryer_out.txt

# get the inside temperature
TEMP_IN=$(cat dryer_in.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f2)

# get the inside temperature
TEMP_OUT=$(cat dryer_out.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f2)

# get the inside humidity reading
HUMID_IN=$(cat dryer_in.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f3)

# get the outside humidity reading
HUMID_OUT=$(cat dryer_out.txt | sed 's/[A-Za-z*% ]*//g' | grep '=' | cut -d"=" -f3)

#Debug:
echo $TEMP_IN >> debug.log
echo $HUMID_IN >> debug.log
echo $TEMP_OUT >> debug.log
echo $HUMID_OUT >> debug.log

# get the EPOCH date
DATE=$(/bin/date +%s)

# Get Data in RRD
rrdtool update dryer_temp_in.rrd $DATE:$TEMP_IN
rrdtool update dryer_humid_in.rrd $DATE:$HUMID_IN
rrdtool update dryer_temp_out.rrd $DATE:$TEMP_OUT
rrdtool update dryer_humid_out.rrd $DATE:$HUMID_OUT

# Create the Daily Graphs
rrdtool graph --slope-mode /etc/filament/dryer_temp_in_day.png -s -1day DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000:"Inside Temp" -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph --slope-mode /etc/filament/dryer_humid_in_day.png -s -1day DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
rrdtool graph --slope-mode /etc/filament/dryer_temp_out_day.png -s -1day DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph --slope-mode /etc/filament/dryer_humid_out_day.png -s -1day DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
/bin/cp /etc/filament/dryer_temp_in_day.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_in_day.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_temp_out_day.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_out_day.png /mnt/share/temperatures/dryer/

#create weekly graph
rrdtool graph /etc/filament/dryer_temp_in_week.png -s -1week DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_in_week.png -s -1week DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
rrdtool graph /etc/filament/dryer_temp_out_week.png -s -1week DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_out_week.png -s -1week DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
/bin/cp /etc/filament/dryer_temp_in_week.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_in_week.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_temp_out_week.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_out_week.png /mnt/share/temperatures/dryer/

#create monthly graph
rrdtool graph /etc/filament/dryer_temp_in_month.png -s -1month DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_in_month.png -s -1month DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
rrdtool graph /etc/filament/dryer_temp_out_month.png -s -1month DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_out_month.png -s -1month DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/dryer_temp_in_month.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_in_month.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_temp_out_month.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_out_month.png /mnt/share/temperatures/dryer/

#create yearly graph
rrdtool graph /etc/filament/dryer_temp_in_year.png -s -1year DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_in_year.png -s -1year DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
rrdtool graph /etc/filament/dryer_temp_out_year.png -s -1year DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_out_year.png -s -1year DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/dryer_temp_in_year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_in_year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_temp_out_year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_out_year.png /mnt/share/temperatures/dryer/

#Create 2 Year graph
rrdtool graph /etc/filament/dryer_temp_in_2year.png -s -2year DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_in_2year.png -s -2year DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
rrdtool graph /etc/filament/dryer_temp_out_2year.png -s -2year DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_out_2year.png -s -2year DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/dryer_temp_in_2year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_in_2year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_temp_out_2year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_out_2year.png /mnt/share/temperatures/dryer/

#Create 5 Year graph
rrdtool graph /etc/filament/dryer_temp_in_5year.png -s -5year DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_in_5year.png -s -5year DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 
rrdtool graph /etc/filament/dryer_temp_out_5year.png -s -5year DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/dryer_humid_out_5year.png -s -5year DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/dryer_temp_in_5year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_in_5year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_temp_out_5year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/dryer_humid_out_5year.png /mnt/share/temperatures/dryer/

#Create the combined daily graph
rrdtool graph /etc/filament/combine_dryer_temp_day.png -s -1day DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/combine_dryer_humid_day.png -s -1day DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/combine_dryer_temp_day.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/combine_dryer_humid_day.png /mnt/share/temperatures/dryer/

#Create the combined weekly graph
rrdtool graph /etc/filament/combine_dryer_temp_week.png -s -1week DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#00FF00 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/combine_dryer_humid_week.png -s -1week DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#FF00FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/combine_dryer_temp_week.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/combine_dryer_humid_week.png /mnt/share/temperatures/dryer/

#Create the combined monthly graph
rrdtool graph /etc/filament/combine_dryer_temp_month.png -s -1month DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/combine_dryer_humid_month.png -s -1month DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/combine_dryer_temp_month.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/combine_dryer_humid_month.png /mnt/share/temperatures/dryer/

#Create the combined yearly graph
rrdtool graph /etc/filament/combine_dryer_temp_year.png -s -1year DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/combine_dryer_humid_year.png -s -1year DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/combine_dryer_temp_year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/combine_dryer_humid_year.png /mnt/share/temperatures/dryer/

#Create the combined 2 year graph
rrdtool graph /etc/filament/combine_dryer_temp_2year.png -s -2year DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/combine_dryer_humid_2year.png -s -2year DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/combine_dryer_temp_2year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/combine_dryer_humid_2year.png /mnt/share/temperatures/dryer/

#Create the combined 5 year graph
rrdtool graph /etc/filament/combine_dryer_temp_5year.png -s -5year DEF:dryer_temp_in=dryer_temp_in.rrd:temp:AVERAGE LINE1:dryer_temp_in#FF0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_temp_out=dryer_temp_out.rrd:temp:AVERAGE LINE1:dryer_temp_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
rrdtool graph /etc/filament/combine_dryer_humid_5year.png -s -5year DEF:dryer_humid_in=dryer_humid_in.rrd:temp:AVERAGE LINE1:dryer_humid_in#0000FF -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000 DEF:dryer_humid_out=dryer_humid_out.rrd:temp:AVERAGE LINE1:dryer_humid_out#ff0000 -h 400 -w 600 -y1:2 --color GRID#000000 --color MGRID#000000
/bin/cp /etc/filament/combine_dryer_temp_5year.png /mnt/share/temperatures/dryer/
/bin/cp /etc/filament/combine_dryer_humid_5year.png /mnt/share/temperatures/dryer/

#Copy RRD to Share
/usr/bin/rrdtool dump dryer_temp_in.rrd dryer_temp_in.xml
/usr/bin/rrdtool dump dryer_humid_in.rrd dryer_humid_in.xml
/usr/bin/rrdtool dump dryer_temp_out.rrd dryer_temp_out.xml
/usr/bin/rrdtool dump dryer_humid_out.rrd dryer_humid_out.xml
/bin/rm /mnt/share/temperatures/dryer/dryer_temp_in.rrd
/bin/rm /mnt/share/temperatures/dryer/dryer_temp_in.xml
/bin/rm /mnt/share/temperatures/dryer/dryer_humid_in.rrd
/bin/rm /mnt/share/temperatures/dryer/dryer_humid_in.xml
/bin/rm /mnt/share/temperatures/dryer/dryer_temp_out.rrd
/bin/rm /mnt/share/temperatures/dryer/dryer_temp_out.xml
/bin/rm /mnt/share/temperatures/dryer/dryer_humid_out.rrd
/bin/rm /mnt/share/temperatures/dryer/dryer_humid_out.xml
/bin/cp dryer_temp_in.rrd /mnt/share/temperatures/dryer/
/bin/cp dryer_temp_in.xml /mnt/share/temperatures/dryer/
/bin/cp dryer_humid_in.rrd /mnt/share/temperatures/dryer/
/bin/cp dryer_humid_in.xml /mnt/share/temperatures/dryer/
/bin/cp dryer_temp_out.rrd /mnt/share/temperatures/dryer/
/bin/cp dryer_temp_out.xml /mnt/share/temperatures/dryer/
/bin/cp dryer_humid_out.rrd /mnt/share/temperatures/dryer/
/bin/cp dryer_humid_out.xml /mnt/share/temperatures/dryer/
