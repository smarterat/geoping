#!/bin/bash

# geoping.sh - https://github.com/smarterat/geoping
# A simple geoip location script via ipinfodb.com using
# wget | sed, because registering for an api key is silly.

if [ "$1" == "" ]; then
  echo "Usage: $0 [IP Address]"
else
  echo ""
  echo "Geopinging         > $1"
  echo "Console time       > $(date +'%B %d %H:%M:%S')"

  var_url="http://ipinfodb.com/ip_locator.php?ip=$1"
  dat_raw=`wget -q $var_url -O - `

  var_ip=`echo "$dat_raw" | grep "IP address : " | sed -e 's/^[ \t]*//' -e 's/<li>IP address : //' -e 's/<strong>//' -e 's/<\/strong>//' -e 's/<\/li>//'`
  var_country=`echo "$dat_raw" | grep "Country : " | sed -e 's/^[ \t]*//' -e 's/<li>Country : //' -e 's/<img.*\/>//' -e 's/<\/li>//'`
  var_state=`echo "$dat_raw" | grep "State/Province : " | sed -e 's/^[ \t]*//' -e 's/<li>State\/Province : //' -e 's/<\/li>//'`
  var_city=`echo "$dat_raw" | grep "City : " | sed -e 's/^[ \t]*//' -e 's/<li>City : //' -e 's/<\/li>//'`
  var_hostname=`echo "$dat_raw" | grep "Hostname : " | sed -e 's/^[ \t]*//' -e 's/<li>Hostname : //' -e 's/<\/li>//'`
  var_localtime=`echo "$dat_raw" | grep "Local time : " | sed -e 's/^[ \t]*//' -e 's/<li>Local time : //' -e 's/<\/li>//'`

  echo ""
  echo "IP address         > $var_ip"
  echo "Country            > $var_country"
  echo "State/Province     > $var_state"
  echo "City               > $var_city"
  echo "Hostname           > $var_hostname"
  echo "Local time         > $var_localtime"
  echo ""
fi