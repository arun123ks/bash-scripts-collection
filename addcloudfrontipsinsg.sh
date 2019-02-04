#!/bin/bash
sgid =""

cdrlst=(`jq -r '.prefixes[]  | select(.service=="CLOUDFRONT") | .ip_prefix' < ip-ranges.json`)

artck=${#cdrlst[@]}
echo $artck
artc=$((artck-1))
for (( x = 0 ; x <= $artc ; x++));
do

aws ec2 authorize-security-group-ingress --group-id $sgid --ip-permissions IpProtocol=tcp,FromPort=80,ToPort=443,IpRanges=[{CidrIp=${cdrlst[x]}}]


done 


