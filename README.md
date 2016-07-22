# docker_baikal

## Baikal 0.4.5 with phusion/baseimage:0.9.19, php7 and Apache2 

### Usage

```
docker run \
    --name baikal \
    --publish 80:80 \
    -v <local-baikal-sqlite-db-path>:/var/www/baikal/Specific \
    --restart always \
    sparklyballs/baikal
```

`local-baikal-sqlite-db-path` is the optional local path you want to use for a
sqlite db. this has the advantage of preserving your data.
