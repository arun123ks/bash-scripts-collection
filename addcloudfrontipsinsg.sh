#!/bin/bash
#How to run it 
#/bin/bash addcloudfrontipsinsg.sh <vpcid>

# Checking VPC id is given or not

if [ -z $1 ];

then 
     echo "Please enetr a valid security group id"
     exit 
else 
     echo "foudn security group value" 
fi      

#Downloading IP list files
wget -q https://ip-ranges.amazonaws.com/ip-ranges.json

#Creating security group
aws ec2 create-security-group --group-name MySecurityGroup --description "My security group" --vpc-id $1

sgid="aws ec2 describe-security-groups --output=text | grep "MySecurityGroup" | grep "sg-" | awk {'print $3'}"

echo "$sgid is new security group id"

#Adding IPs to security groups
cdrlst=(`jq -r '.prefixes[]  | select(.service=="CLOUDFRONT") | .ip_prefix' < ip-ranges.json`)

artck=${#cdrlst[@]}
echo $artck
artc=$((artck-1))
for (( x = 0 ; x <= $artc ; x++));
do

aws ec2 authorize-security-group-ingress --group-id $sgid --ip-permissions IpProtocol=tcp,FromPort=80,ToPort=443,IpRanges=[{CidrIp=${cdrlst[x]}}]


done 


