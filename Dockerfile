FROM elasticsearch:5.2.0

MAINTAINER Joao Daher <joao.daher.neto@gmail.com>

RUN elasticsearch-plugin install --batch x-pack

ADD ./plugins/hunspell /usr/share/elasticsearch/config/hunspell
ADD ./plugins/analysis-phonetic-5.2.0.zip /tmp
RUN elasticsearch-plugin install file:///tmp/analysis-phonetic-5.2.0.zip
RUN elasticsearch-plugin install ingest-attachment
RUN elasticsearch-plugin install ingest-geoip
RUN elasticsearch-plugin install ingest-user-agent

ADD ./config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

CMD ["-E", "network.host=0.0.0.0", "-E", "discovery.zen.minimum_master_nodes=1"]
