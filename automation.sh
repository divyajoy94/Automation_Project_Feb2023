#!bin/bash 
timestamp=$(date '+%Y%m%d-%H%M%S')
name='sharveshwari'
s3_bucket='upgradsharveshwari'
cp /var/log/apache2/*.log /tmp
filename=${name}'-httpd-logs-'${timestamp}
cd /tmp; rm -rf *.tar; tar -zcvf $filename.tar *.log
aws s3 cp /tmp/${filename}.tar s3://${s3_bucket}/${filename}.tar
cd /etc/cron.d
CronFile="automation"
if [ ! -f "$CronFile" ]
then
        echo "0 0 * * * root /root/Automation_Project/automation.sh" >> $CronFile
fi
cd /tmp
var=$(find . -name '*.tar' -printf "%TY%Tm%Td-%TH%TM%TS" | grep -o '^[^\.]*')
size=$((($(stat -c %s *.tar ) + 1023) / 1024 ))K
cd /var/www/html/
File="inventory.html"
if test -f "$File"
then
        echo "<p>httpd-logs<span class="tab"></span>$var<span class="tab"></span>tar<span class="tab"></span>$size</p>" >> $File
else
        cat > $File <<EOF
<!DOCTYPE html>
<html>
<head>
<style>
    .tab {
        display: inline-block;
        margin-left: 70px;
    }
</style>
</head>
<body>
<p><strong>Log Type<span class="tab"></span>Time Created<span class="tab"></span>Type<span class="tab"></span>Size</strong></p>
<p>httpd-logs<span class="tab"></span>$var<span class="tab"></span>tar<span class="tab"></span>$size</p>
</body>
</html>
EOF
fi
