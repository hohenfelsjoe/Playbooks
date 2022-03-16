#! /bin/sh

##Clean Metadata##
/usr/bin/dnf clean metadata

##Clean the Rest##
/usr/bin/dnf clean all

##Update##
/usr/bin/dnf -y update

##RootKit Check
#/usr/bin/rkhunter --update
#/usr/bin/rkhunter --checkall

echo "###########################################################"
echo "# If updates applied run sudo /usr/bin/rkhunter --propupd #"
echo "###########################################################"

