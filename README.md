squid-deb-proxy Docker container
================================

squid-deb-proxy provides an easy wrapper over squid to enable package proxy caching for your organisation/LAN.
[Readme](https://bazaar.launchpad.net/~squid-deb-proxy-developers/squid-deb-proxy/trunk/view/head:/README.md)

This Docker container image allows most (if not all) non-routeable LAN subnets and caches from sources found under `extra-sources.acl`

You can also mount a volume to the source address acl directories to add your own sources and ip ranges.

Usage:

* On Server / Host:

```bash
docker run --name proxy --rm -v /path/to/cachedir:/var/cache/squid-deb-proxy  -v /path/to/allowed-networks:/etc/squid-deb-proxy/allowed-networks-src.acl.d /
 -v /path/to/cached-sources:/etc/squid-deb-proxy/mirror-dstdomain.acl.d -p PORT:8000 jack60612/squid-deb-proxy 
```

* On a node

```bash
apt install squid-deb-proxy-client
echo 'Acquire::http::Proxy "http://HOST_IP:PORT";' > /etc/apt/apt.conf.d/30autoproxy
```

or

```bash
apt install auto-apt-proxy
```
