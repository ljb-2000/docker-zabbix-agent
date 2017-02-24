FROM oberthur/docker-ubuntu:16.04

MAINTAINER Michal Dziedziela <m.dziedziela@oberthur.com>

ENV ZABBIX_VERSION 3.0

RUN \
  apt-get update && \
  apt-get install -y wget && \
  wget -qO - http://repo.zabbix.com/zabbix-official-repo.key | apt-key add - && \
  echo "deb http://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/ubuntu xenial main" > /etc/apt/sources.list.d/zabbix.list && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y zabbix-agent zabbix-sender python3-pip python3-setuptools python3-wheel && \
  pip3 install -U pip setuptools py-zabbix prometheus_client simplejson requests wheel

COPY ./zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf
COPY ./zabbix-agent.sh /bin/zabbix-agent.sh

RUN mkdir /var/run/zabbix/ && \
  chown zabbix:zabbix /var/run/zabbix/

ENTRYPOINT ["/bin/zabbix-agent.sh"]
