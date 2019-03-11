#!/bin/bash
find /var/www/public_html -type d  -exec chmod 755 {} \;
find /var/www/public_html -type f  -exec chmod 664 {} \;
chmod 777 /var/www/public_html/cache -R   
chmod 777 /var/www/public_html/images -R  
chown root:www-data /var/www/public_html -R
