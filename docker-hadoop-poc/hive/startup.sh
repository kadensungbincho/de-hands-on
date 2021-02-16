#!/bin/bash

hadoop fs -mkdir       /tmp
hadoop fs -mkdir -p    /user/hive/warehouse
hadoop fs -chmod g+w   /tmp
hadoop fs -chmod g+w   /user/hive/warehouse
# Add user
groupadd hadoop
useradd -g hadoop kaden
hadoop fs -mkdir /user/kaden/
hadoop fs -chown -R kaden:hadoop /user/kaden
hdfs dfsadmin -refreshUserToGroupsMappings
echo "dummy in trash" >> tmp.txt
hdfs dfs -mkdir -p /user/kaden/.Trash/Current
hdfs dfs -put tmp.txt hdfs:///user/kaden/.Trash/Current/tmp.txt

if [ "$DUMMY_DATA" = "1" ]; then
  DATE_FORMAT='+%Y%m%d'
  HOUR_FORMAT='+%Y%m%d%H'
  MONTH_FORMAT='+%Y%m'
  d1_dt=$(date -d "yesterday 00:00" $DATE_FORMAT)
  d6_dt=$(date -d "6 days ago" $DATE_FORMAT)
  d7_dt=$(date -d "7 days ago" $DATE_FORMAT)
  d8_dt=$(date -d "8 days ago" $DATE_FORMAT)
  h100_dt=$(date -d "100 hours ago" $HOUR_FORMAT)
  h200_dt=$(date -d "200 hours ago" $HOUR_FORMAT)
  h250_dt=$(date -d "250 hours ago" $HOUR_FORMAT)
  m1_dt=$(date -d "1 months ago" $MONTH_FORMAT)
  m2_dt=$(date -d "2 months ago" $MONTH_FORMAT)
  echo "inject ${d1_dt}"
  hive -hiveconf d1_dt="$d1_dt" \
        -hiveconf d6_dt="$d6_dt" \
        -hiveconf d7_dt="$d7_dt" \
        -hiveconf d8_dt="$d8_dt" \
        -hiveconf h100_dt="$h100_dt" \
        -hiveconf h200_dt="$h200_dt" \
        -hiveconf h250_dt="$h250_dt" \
        -hiveconf m1_dt="$m1_dt" \
        -hiveconf m2_dt="$m2_dt" \
        -f /opt/dummy_data/tmp.hql
fi

cd $HIVE_HOME/bin

if [ "$1" == "metastore" ]
then
  ./schematool -dbType mysql -initSchema --verbose &&
  ./hive --service metastore
else
  echo "execute the default, which is hiveserver2"
  $RANGER_HIVE_PLUGIN_HOME/enable-hive-plugin.sh &&
  ./hiveserver2  --hiveconf hive.server2.enable.doAs=true
fi
