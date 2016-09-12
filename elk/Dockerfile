FROM sebp/elk:es234_l234_k453

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}

ARG DEBIAN_FRONTEND=noninteractive
RUN set -x \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends nodejs npm \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g elasticdump

RUN gosu elasticsearch bin/plugin install mobz/elasticsearch-head

RUN ln -s /usr/bin/nodejs /usr/bin/node

COPY kibana.json /
COPY start-and-load-kibana-data.sh /
ADD 02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf
ADD 30-output.conf /etc/logstash/conf.d/30-output.conf

CMD [ "/start-and-load-kibana-data.sh" ]