#!/usr/bin/env bash

IMPORT_NETWORK=elk-export
docker network create $EXPORT_NETWORK
docker network connect $EXPORT_NETWORK elk
docker run --rm --net=$EXPORT_NETWORK vfarcic/elastic-dump --input=http://elk:9200/.kibana --output=$ --type=data > kibana.json
docker network disconnect $EXPORT_NETWORK elk
docker network rm $EXPORT_NETWORK