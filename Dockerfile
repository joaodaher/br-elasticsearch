# Dockerfile for Elasticsearch (Kubernetes-Ready)
# Elasticsearch 5.4.1

# Build with:
# docker build -t joaodaher/elasticsearch .

# Run with:
# docker run -p 9200:9200 -it --name elk joaodaher/elasticsearch

FROM quay.io/pires/docker-elasticsearch:5.4.1
MAINTAINER Joao Daher <joao.daher.neto@gmail.com>
ENV REFRESHED_AT 2017-06-10



###############################################################################
#                               CONFIGURATION
###############################################################################

### configure Elasticsearch

ADD config /elasticsearch/config

RUN /elasticsearch/bin/elasticsearch-plugin install --batch x-pack

ADD ./plugins/hunspell /elasticsearch/config/hunspell
ADD ./plugins/geoip /elasticsearch/config/ingest-geoip
#ADD ./plugins/analysis-phonetic-${ES_VERSION}.zip /tmp
#RUN /elasticsearch/bin/elasticsearch-plugin install file:///tmp/analysis-phonetic-${ES_VERSION}.zip
RUN /elasticsearch/bin/elasticsearch-plugin ingest-attachment
RUN /elasticsearch/bin/elasticsearch-plugin ingest-geoip
RUN /elasticsearch/bin/elasticsearch-plugin ingest-user-agent




ENV DISCOVERY_SERVICE elasticsearch-discovery
