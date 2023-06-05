#!/bin/bash

#Create the combined daily graph
rrdtool graph /var/www/html/solar/combine_day.png -s -1day DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined weekly graph
rrdtool graph /var/www/html/solar/combine_week.png -s -1week DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined monthly graph
rrdtool graph /var/www/html/solar/combine_month.png -s -1month DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly graph
rrdtool graph /var/www/html/solar/combine_year.png -s -1year DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Kill any rrdtool running
killall -9 rrdtool
