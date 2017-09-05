#!/usr/bin/env bash

echo -e "\n\nStarting Opentsdb:"

trap_func(){
    echo -e "\n\nShutting down Opentsdb:"
}
trap trap_func INT QUIT TRAP ABRT TERM EXIT

max_tags=${MAX_TAGS:-"8"}

table_prefix=""

if [ -n "$TABLE_PREFIX" ]; then
    table_prefix="${TABLE_PREFIX}-"
fi

echo table_prefix=$table_prefix
echo max_tags=$max_tags
echo ZK_QUORUM=$ZK_QUORUM

sed -i "s|{{table_prefix}}|$table_prefix|g" /opentsdb/opentsdb.conf
sed -i "s|{{zk_quorum}}|$ZK_QUORUM|g" /opentsdb/opentsdb.conf
sed -i "s|{{max_tags}}|$max_tags|g" /opentsdb/opentsdb.conf

# [ -d /var/log/opentsdb ] || mkdir -p /var/log/opentsdb
[ -f /var/log/opentsdb/opentsdb.log ] || touch /var/log/opentsdb/opentsdb.log

# /usr/share/opentsdb/bin/tsdb tsd --auto-metric &

# tail -f /var/log/opentsdb/opentsdb.log

/opt/opentsdb/bin/tsdb tsd --auto-metric
