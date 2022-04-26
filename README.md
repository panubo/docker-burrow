# Burrow Monitor for Kafka

Docker image for [burrow](https://github.com/linkedin/Burrow/). Configuration documentation is available at the [burrow wiki](https://github.com/linkedin/Burrow/wiki/Configuration).

This image runs as `uid=1000(user) gid=1000(user)` by default and with working dir `/tmp` so the `burrow.pid` can be written. These can be overwritten with `docker run --user XXX --workdir /` etc.

## Status

In production.
