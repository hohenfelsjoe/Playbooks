#!/bin/bash

#take a break
sleep 15

#Get into the correct Spot
cd /etc/temperatures/

#Get cleaned up and re-create the database
#rm *.rrd
/bin/cp /mnt/share/Temperatures/*.xml /etc/temperatures/
rrdtool restore armory_temp.xml armory_temp.rrd
rrdtool restore shop_humid.xml shop_humid.rrd
rrdtool restore shop_temp.xml shop_temp.rrd
rrdtool restore greatroom_humid.xml greatroom_humid.rrd
rrdtool restore house_temp.xml house_temp.rrd
rrdtool restore attic_humid.xml attic_humid.rrd
rrdtool restore ammo_humid.xml ammo_humid.rrd
rrdtool restore barn_humid.xml barn_humid.rrd
rrdtool restore ammo_temp.xml ammo_temp.rrd
rrdtool restore barn_temp.xml barn_temp.rrd
rrdtool restore bench_temp.xml bench_temp.rrd
rrdtool restore bench_humid.xml bench_humid.rrd

#Create the combined daily temperature graph
rrdtool graph /var/www/html/temperatures/combine_day.png -s -1day DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600:"Armory" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff:"Shop" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa  DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_temp=barn_temp.rrd:temp:AVERAGE LINE1:barn_temp#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined daily humid graph
rrdtool graph /var/www/html/temperatures/combine_humid_day.png -s -1day DEF:shop_humid=shop_humid.rrd:temp:AVERAGE LINE1:shop_humid#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:greatroom_humid=greatroom_humid.rrd:temp:AVERAGE LINE1:greatroom_humid#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:barn_humid=barn_humid.rrd:temp:AVERAGE LINE1:barn_humid#ff0000 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined weekly temperature graph
rrdtool graph /var/www/html/temperatures/combine_week.png -s -1week DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600:"Armory" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa  DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined weekly humid graph
rrdtool graph /var/www/html/temperatures/combine_humid_week.png -s -1week DEF:shop_humid=shop_humid.rrd:temp:AVERAGE LINE1:shop_humid#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:greatroom_humid=greatroom_humid.rrd:temp:AVERAGE LINE1:greatroom_humid#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined monthly temperature graph
rrdtool graph /var/www/html/temperatures/combine_month.png -s -1month DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600:"Armory" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa  DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined monthly humid graph
rrdtool graph /var/www/html/temperatures/combine_humid_month.png -s -1month DEF:shop_humid=shop_humid.rrd:temp:AVERAGE LINE1:shop_humid#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:greatroom_humid=greatroom_humid.rrd:temp:AVERAGE LINE1:greatroom_humid#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly temperature graph
rrdtool graph /var/www/html/temperatures/combine_1year.png -s -1year DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600:"Armory" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa  DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly humid graph
rrdtool graph /var/www/html/temperatures/combine_humid_1year.png -s -1year DEF:shop_humid=shop_humid.rrd:temp:AVERAGE LINE1:shop_humid#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:greatroom_humid=greatroom_humid.rrd:temp:AVERAGE LINE1:greatroom_humid#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly temperature graph
rrdtool graph /var/www/html/temperatures/combine_2year.png -s -2year DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600:"Armory" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa  DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly humid graph
rrdtool graph /var/www/html/temperatures/combine_humid_2year.png -s -2year DEF:shop_humid=shop_humid.rrd:temp:AVERAGE LINE1:shop_humid#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:greatroom_humid=greatroom_humid.rrd:temp:AVERAGE LINE1:greatroom_humid#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly temperature graph
rrdtool graph /var/www/html/temperatures/combine_5year.png -s -5year DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600:"Armory" -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa  DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined yearly humid graph
rrdtool graph /var/www/html/temperatures/combine_humid_5year.png -s -5year DEF:shop_humid=shop_humid.rrd:temp:AVERAGE LINE1:shop_humid#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:greatroom_humid=greatroom_humid.rrd:temp:AVERAGE LINE1:greatroom_humid#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:attic_humid=attic_humid.rrd:temp:AVERAGE LINE1:attic_humid#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo daily temperature graph
rrdtool graph /var/www/html/temperatures/combine_ammo_temp_day.png -s -1day DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo daily humid graph
rrdtool graph /var/www/html/temperatures/combine_ammo_humid_day.png -s -1day DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo weekly graph
rrdtool graph /var/www/html/temperatures/combine_ammo_temp_week.png -s -1week DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_temp=ammo_temp.rrd:temp:AVERAGE LINE1:ammo_temp#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo weekly humid graph
rrdtool graph /var/www/html/temperatures/combine_ammo_humid_week.png -s -1week DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo monthly graph
rrdtool graph /var/www/html/temperatures/combine_ammo_temp_month.png -s -1month DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo monthly humid graph
rrdtool graph /var/www/html/temperatures/combine_ammo_humid_month.png -s -1month DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo yearly graph
rrdtool graph /var/www/html/temperatures/combine_ammo_temp_1year.png -s -1year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo yearly humid graph
rrdtool graph /var/www/html/temperatures/combine_ammo_humid_1year.png -s -1year DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo yearly graph
rrdtool graph /var/www/html/temperatures/combine_ammo_temp_2year.png -s -2year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo yearly humid graph
rrdtool graph /var/www/html/temperatures/combine_ammo_humid_2year.png -s -2year DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo yearly graph
rrdtool graph /var/www/html/temperatures/combine_ammo_temp_5year.png -s -5year DEF:bench_temp=bench_temp.rrd:temp:AVERAGE LINE1:bench_temp#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:armory_temp=armory_temp.rrd:temp:AVERAGE LINE1:armory_temp#4d2600 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:shop_temp=shop_temp.rrd:temp:AVERAGE LINE1:shop_temp#0000ff -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:house_temp=house_temp.rrd:temp:AVERAGE LINE1:house_temp#e600e6 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa

#Create the combined ammo yearly humid graph
rrdtool graph /var/www/html/temperatures/combine_ammo_humid_5year.png -s -5year DEF:bench_humid=bench_humid.rrd:temp:AVERAGE LINE1:bench_humid#D27D2D -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa DEF:ammo_humid=ammo_humid.rrd:temp:AVERAGE LINE1:ammo_humid#00ff00 -h 400 -w 600 -y1:2 --color GRID#dddddd --color MGRID#aaaaaa


#Copy the images to the share
/bin/cp /var/www/html/temperatures/combine* /mnt/share/Temperatures/
/bin/cp /mnt/share/Temperatures/*.png /var/www/html/temperatures/
/bin/cp /mnt/share/Temperatures/dryer/*.png /var/www/html/dryer/
rm *.rrd
rm *.xml

