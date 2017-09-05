# OpenTSDB

How to run:

```
# for test

docker run -d --name hbase -p 2181:2181 -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9095:9095 -p 16000:16000 -p 16010:16010 -p 16201:16201 -p 16301:16301 harisekhon/hbase

docker run -d --name tsdb -e MAX_TAGS=12 -e ZK_QUORUM=172.17.0.2 -e TABLE_PREFIX=alauda:dev -p 4242:4242 --add-host=05b47ade90be:172.17.0.2 liubin/opentsdb:2.3
```
# Operations

## Create Tables

```
```

## Set ttl

```
alter 'tsdb', NAME=>'t', TTL=>1209600
```