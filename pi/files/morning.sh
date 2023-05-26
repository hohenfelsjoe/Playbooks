#! /bin/sh

echo ""
echo "#Update everything"
echo ""

/usr/bin/apt clean all
/usr/bin/apt update -y
/usr/bin/apt upgrade -y
/usr/bin/apt dist-upgrade -y 
/usr/bin/apt autoremove -y 

#Share work
#Remove Meta Data from share directory
#exiftool -progress -r -overwrite_original -all= -copyright="NONEYA LLC" /mnt/share/Tmp
#exiftool -progress -r -overwrite_original -all= -copyright="NONEYA LLC" /mnt/share/Videos/Tmp_Video


#Verify Permissions
chmod -R 777 /mnt/share/Tmp

##RootKit Check
#/usr/bin/rkhunter --update
#/usr/bin/rkhunter --checkall
echo "###########################################################"
echo "# If updates applied run sudo /usr/bin/rkhunter --propupd #"
echo "###########################################################"

