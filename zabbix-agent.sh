#!/bin/bash

ZABBIX_SERVER=${ZABBIX_SERVER}
FQDN=${FQDN}
ZABBIX_METADATA=${ZABBIX_METADATA}

if [ -n "$ZABBIX_SERVER" ]; then
  sed -i -e "s/ServerActive={{- zabbix_server -}}/ServerActive=${ZABBIX_SERVER}/g" /etc/zabbix/zabbix_agentd.conf
else
  echo "No ZABBIX_SERVER env set, exiting ..."
  exit -1
fi

if [ -n "$FQDN" ]; then
  sed -i -e "s/Hostname={{- fqdn -}}/Hostname=${FQDN}/g" /etc/zabbix/zabbix_agentd.conf
else
  echo "No FQDN env set, using default ..."
  sed -i -e "s/Hostname={{- fqdn -}}/Hostname=${HOSTNAME}/g" /etc/zabbix/zabbix_agentd.conf
fi

if [ -n "$ZABBIX_METADATA" ]; then
  sed -i -e "s/HostMetadata={{- zabbix_metadata -}}/HostMetadata=${ZABBIX_METADATA}/g" /etc/zabbix/zabbix_agentd.conf
else
  echo "No ZABBIX_METADATA env set, using default ..."
  sed -i -e "s/HostMetadata={{- zabbix_metadata -}}/HostMetadata=None/g" /etc/zabbix/zabbix_agentd.conf
fi

zabbix_agentd -f
