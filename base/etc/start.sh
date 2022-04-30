#!/bin/ash
PATH="/sbin:/bin"
echo "Starting RouterF at $(/bin/date)"
httpd -f -vv -p 127.0.0.1:8000 -h /http/www

