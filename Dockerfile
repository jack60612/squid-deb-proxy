FROM ubuntu:latest
MAINTAINER Jack Nelson <jack@jacknelson.xyz>

ENV DEBIAN_FRONTEND noninteractive
ENV ENAVBLE_AVAHI true

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      squid-deb-proxy avahi-daemon avahi-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    ln -sf /cachedir /var/cache/squid-deb-proxy && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/access.log && \
    ln -sf /dev/stdout /var/log/squid-deb-proxy/store.log &&\
    ln -sf /dev/stdout /var/log/squid-deb-proxy/cache.log

# add default extra sources to main sources so not accidently overwritten
COPY extra-sources.acl extra-sources.acl
RUN cat extra-sources.acl >> /etc/squid-deb-proxy/mirror-dstdomain.acl && \
    rm extra-sources.acl

# prep start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

VOLUME ["/var/cache/squid-deb-proxy"]

# Whitelist additional network ranges
VOLUME ["/etc/squid-deb-proxy/allowed-networks-src.acl.d"]

# Whitelist additional domains
VOLUME ["/etc/squid-deb-proxy/mirror-dstdomain.acl.d"]

EXPOSE 8000
EXPOSE 5353/udp

LABEL SERVICE_NAME="squid-deb-proxy"
LABEL SERVICE_TAGS="apt-proxy,apt-cache"

ENTRYPOINT ["/start.sh"]
