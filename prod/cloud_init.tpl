#!/bin/bash
sudo yum install busybox -y
echo "Hello, ${firstname}" > index.html
nohup busybox httpd -f -p 8080 &
