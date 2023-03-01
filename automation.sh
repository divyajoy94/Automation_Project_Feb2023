#!bin/bash 
timestamp=$(date '+%Y%m%d-%H%M%S')
name='sharveshwari'
s3_bucket='upgradsharveshwari'
cp /var/log/apache2/*.log /tmp
filename=${name}'-httpd-logs-'${timestamp}
cd /tmp; rm -rf *.tar; tar -zcvf $filename.tar *.log
aws s3 cp /tmp/${filename}.tar s3://${s3_bucket}/${filename}.tar
