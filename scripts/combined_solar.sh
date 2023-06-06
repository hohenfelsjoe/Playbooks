#!/bin/bash

#Create the combined daily graph
rrdtool graph /var/www/html/solar/combine_day.png -s -1day DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900:"Usage" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000:"Production" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined weekly graph
rrdtool graph /var/www/html/solar/combine_week.png -s -1week DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900:"Usage" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000:"Production" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined monthly graph
rrdtool graph /var/www/html/solar/combine_month.png -s -1month DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900:"Usage" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000:"Production" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly graph
rrdtool graph /var/www/html/solar/combine_year.png -s -1year DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900:"Usage" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000:"Production" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined 2year graph
rrdtool graph /var/www/html/solar/combine_2year.png -s -2year DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900:"Usage" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000:"Production" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined 5year graph
rrdtool graph /var/www/html/solar/combine_5year.png -s -5year DEF:ted_watts=/etc/ted/watts/ted_watts.rrd:temp:AVERAGE LINE1:ted_watts#FF9900:"Usage" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:enphase=/etc/enphase/enphase.rrd:temp:AVERAGE LINE1:enphase#FF0000:"Production" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Kill any rrdtool running
killall -9 rrdtool
