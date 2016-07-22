# docker_baikal

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
