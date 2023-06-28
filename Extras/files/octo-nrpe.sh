#!/bin/bash

#Get the Status
STATUS=$(octoprint-cli print status | head -n 1)

#Get whats Printing
NAME=$(octoprint-cli print status | head -n 2 | grep File: | cut -d":" -f2 | cut -d "." -f1)

#Get the Progress
PROG=$(octoprint-cli print status | grep Pro | cut -d":" -f2)

if [[ $STATUS = *Printing* ]];then
  echo "OK - $NAME is still printing. $PROG Done!"
  exit 0
elif [[ $STATUS = *Operational* ]];then
  echo "WARNING - Printers Hanging out"
  exit 1
elif [[ $STATUS = *Disconnected* ]];then
  echo "CRITICAL - Printer is Disconnected!"
  exit 2
else
  echo "UNKNOWN - Go Check"
  exit 3
fi

