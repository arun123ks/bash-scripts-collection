#!/bin/bash
orgt=`netstat -nalp | grep $1 | grep python3.6 | awk {'print $1'}`
krgt="tcp"

if [ "$orgt" = "$krgt" ];
then
	echo "service is running"
else
        echo "service is not running, starting"	
        cd $2
        nohup python3.6 run.py &	
fi
