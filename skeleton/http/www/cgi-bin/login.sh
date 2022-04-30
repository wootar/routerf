#!/bin/ash

echo "Content-type: text/html"
echo ""

# tmp=$(echo $QUERY_STRING | sed "s/&/\n/g" | awk 'NR==2{ print; exit }' | sed 's/pass=//g')

# [ "$(echo $tmp | /bin/md5)" = $(cat /http/priv/password) ] && cat /http/priv/ui.html || echo invaild

cat /http/priv/ui.html