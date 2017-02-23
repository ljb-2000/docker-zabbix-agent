# Zabbix agent docker image

## Building docker image

```
docker build -t <your_image_name>:<your_image_tag> .
```
## Configuration

Docker image is configured by environment variables.

`ZABBIX_SERVER` - set zabbix server

`FQDN` - set hostname to advertise on zabbix server ( default: `$HOSTNAME` variable)

`ZABBIX_METADATA` - add zabbix metadata

## Running image

### `docker run`

```
docker run -d \
-e ZABBIX_SERVER=<your_zabbix_server_address \
-e FQDN=<you_host_name> \
-e ZABBIX_METADATA=<zabbix_metadata> \
<your_image_name>:<your_image_tag>
```

### `docker-compose`

```
zabbix-agent:
  container_name: zabbix-agent
  image: <your_image_name>:<your_image_tag>
  
  environment:
    - ZABBIX_SERVER=<your_zabbix_server_address>
    - FQDN=<you_host_name>
    - ZABBIX_METADATA=<zabbix_metadata>
```

### kubernetes

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: zabbix-agent
  namespace: <your_namespace>
  labels:
    app: zabbix-agent
spec:
  replicas: 1
  selector:
    matchLabels:
      app: zabbix-agent
  template:
    metadata:
      name: zabbix-agent
      labels:
        app: zabbix-agent
    spec:
      containers:
      - name: zabbix-agent
        image: <your_image_name>:<your_image_tag>
        
        env:
        - name: ZABBIX_SERVER
          value: <your_zabbix_server_address>
        - name: FQDN
          value: <your_namespace>
        - name: ZABBIX_METADATA
          value: <zabbix_metadata>
```
