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

# zookeeper.znode.parent in hbase config file.
zk_basedir=${ZK_BASEDIR:-"/hbase"}

echo table_prefix=$table_prefix
echo max_tags=$max_tags
echo ZK_QUORUM=$ZK_QUORUM
echo zk_basedir=$zk_basedir

sed -i "s|{{zk_basedir}}|$zk_basedir|g" /opt/opentsdb/opentsdb.conf
sed -i "s|{{table_prefix}}|$table_prefix|g" /opt/opentsdb/opentsdb.conf
sed -i "s|{{zk_quorum}}|$ZK_QUORUM|g" /opt/opentsdb/opentsdb.conf
sed -i "s|{{max_tags}}|$max_tags|g" /opt/opentsdb/opentsdb.conf

# start opentsdb
/opt/opentsdb/build/tsdb tsd --auto-metric --staticroot=/opt/opentsdb/build/staticroot
