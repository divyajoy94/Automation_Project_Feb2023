Task 2: 
  1. This task is to create tar out of log files present under /var/log/apache2/ location of your ec2 instance if apache2 is already present.
  2. Next, we have to push the generated tar to s3
Task 3:
  1. First we need to check if "automation" job file is present under /etc/cron.d to run our script on daily basis. If present we need to skip the file creation, if not the script creates a cron job with name "automation" under /etc/cron.d
  2. Similarly, we need to check if inventory.html file is present under /var/www/html/. If not it creates the same and pushes the tar file with properties to inventory.html
