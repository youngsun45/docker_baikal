# docker_baikal

## Baikal 0.4.5 with phusion/baseimage:0.9.19, php7.0 and Apache2

### Usage

```
docker run \
    --name baikal \
    --publish 80:80 \
    -v <local-baikal-sqlite-db-path>:/var/www/baikal/Specific \
    --restart always \
    sparklyballs/baikal
```


`local-baikal-sqlite-db-path` (optional) is a local path you want to use for a
sqlite db. This has the advantage of simplifying backups and preserving your
data.

If you don't want to use sqlite then simply omit that line.
