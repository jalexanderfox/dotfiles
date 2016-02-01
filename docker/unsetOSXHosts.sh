#!/bin/bash
set -e

me=$(basename "$0")
active=$1
file=$2
echo "=====Executing[${me}]====="; echo ""
if [ -z "$active" ]; then
  active=$(docker-machine active)
  echo "=====[$active] Docker Machine Name====="; echo ""
fi

if [ -z "$file" ]; then
  file="/etc/hosts"
fi

echo "=====[$active] hosts file [${file}]====="; echo ""
cat $file; echo ""

new_ip="$(docker-machine ip $active)"
map="${new_ip}\t www-local.kroger.com www-local.rulerfoods.com www-local.food4less.com www-local.gerbes.com www-local.bakersplus.com www-local.citymarket.com www-local.dillons.com www-local.fredmeyer.com www-local.kingsoopers.com www-local.qfc.com www-local.ralphs.com www-local.smithsfoodanddrug.com www-local.frysfood.com www-local.thelittleclinic.com www-local.owensmarket.com www-local.kwikshop.com www-local.loafnjug.com www-local.quikstop.com www-local.tomt.com www-local.turkeyhillstores.com www-local.jaycfoods.com www-local.ppsrx.com www-local.mainandvineshop.com wta dba int roguedev3"

echo "=====[$active] Removing old hosts map====="; echo ""
sudo sed -i.bak "/www-local\.kroger\.com/d" $file

echo "=====[$active] New hosts file [${file}]====="; echo ""
cat $file; echo ""
