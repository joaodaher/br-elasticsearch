FROM elasticsearch:5.2.0

MAINTAINER Joao Daher <joao.daher.neto@gmail.com>

ENV ES_JAVA_OPTS="-Des.path.conf=/etc/elasticsearch"

RUN elasticsearch-plugin install --batch x-pack

ADD ./plugins/hunspell /usr/share/elasticsearch/config/hunspell
ADD ./plugins/analysis-phonetic-5.2.0.zip /tmp
RUN elasticsearch-plugin install file:///tmp/analysis-phonetic-5.2.0.zip
RUN elasticsearch-plugin install ingest-attachment

ADD ./config/ /usr/share/elasticsearch/config/

CMD ["-E", "network.host=0.0.0.0", "-E", "discovery.zen.minimum_master_nodes=1"]