FROM sebp/elk:es234_l234_k453

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}

RUN gosu elasticsearch bin/plugin install mobz/elasticsearch-head

ADD 02-beats-input.conf /etc/logstash/conf.d/02-beats-input.conf