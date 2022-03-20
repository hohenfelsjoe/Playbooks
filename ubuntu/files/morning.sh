#! /bin/sh

echo ""
echo "#Update everything"
echo ""

/usr/bin/apt clean all
/usr/bin/apt update
/usr/bin/apt upgrade
/usr/bin/apt dist-upgrade
/usr/bin/apt autoremove

#Share work
#Remove Meta Data from share directory
#exiftool -progress -r -overwrite_original -all= -copyright="NONEYA LLC" /home/erik/Videos
#exiftool -progress -r -overwrite_original -all= -copyright="NONEYA LLC" /mnt/share/Videos/Tmp_Video


#Verify Permissions
#chown -R erik.erik /home/erik/Videos

##RootKit Check
#/usr/bin/rkhunter --update
#/usr/bin/rkhunter --checkall
echo "###########################################################"
echo "# If updates applied run sudo /usr/bin/rkhunter --propupd #"
echo "###########################################################"

