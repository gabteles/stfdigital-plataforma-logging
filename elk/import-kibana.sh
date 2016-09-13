#!/usr/bin/env bash

ELK_ALIAS=${1:-elk}

IMPORT_NETWORK=elk-import
docker network create $IMPORT_NETWORK
docker network connect $IMPORT_NETWORK $ELK_ALIAS
MSYS_NO_PATHCONV=1 docker run -i -v /data --entrypoint=bash vfarcic/elastic-dump -c 'cat > /data/kibana.json' < kibana.json
ID=$(docker ps -ql)
MSYS_NO_PATHCONV=1 docker run --rm --net=$IMPORT_NETWORK --volumes-from $ID vfarcic/elastic-dump --input=/data/kibana.json --output=http://$ELK_ALIAS:9200/.kibana --type=data
docker rm -f $ID
docker network disconnect $IMPORT_NETWORK $ELK_ALIAS
docker network rm $IMPORT_NETWORK