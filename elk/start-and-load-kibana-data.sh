#!/usr/bin/env bash

/usr/local/bin/start.sh&

counter=0
while [ ! "$(curl localhost:9200 2> /dev/null)" -a $counter -lt 30  ]; do
    sleep 1
    ((counter++))
    echo "waiting for Elasticsearch to be up ($counter/30)"
done

counter=0
while [ ! "$(curl localhost:5601 2> /dev/null)" -a $counter -lt 30  ]; do
    sleep 1
    ((counter++))
    echo "waiting for Kibana to be up ($counter/30)"
done

elasticdump --input=/kibana.json --output=http://localhost:9200/.kibana --type=data

wait