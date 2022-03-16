#! /bin/sh

##Clean Metadata##
/usr/bin/yum clean metadata

##Clean the Rest##
/usr/bin/yum clean all

##Update##
/usr/bin/yum -y update

##RootKit Check
#/usr/bin/rkhunter --update
#/usr/bin/rkhunter --checkall

echo "###########################################################"
echo "# If updates applied run sudo /usr/bin/rkhunter --propupd #"
echo "###########################################################"

