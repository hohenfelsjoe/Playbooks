#! /bin/sh

setsebool -P httpd_can_network_connect 1
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/hohenfels'
restorecon -v '/var/www/html/hohenfels'
semanage fcontext -a -t httpd_sys_rw_content_t '/var/www/html/viking'
restorecon -v '/var/www/html/viking'
setsebool -P httpd_read_user_content 1

fixfiles -F onboot
