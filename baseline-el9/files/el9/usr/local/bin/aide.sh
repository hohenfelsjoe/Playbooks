#!/bin/sh
/usr/sbin/aide --check | /bin/mail -s "$HOSTNAME - Daily aide integrity check run" root@localhost
