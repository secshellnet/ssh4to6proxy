# SSH 4to6 Proxy

This image provides a ssh proxy, which can be used to make ipv6 hosts reachable from ipv4 only networks.
It has been developed for workshops, where participants are required to connect to ipv6 only hosts.

```shell
ssh -J vyos@proxy vyos@ipv6onlyhost
```

### Docker
Don't forget to enable ipv6 for your docker container!
```javascript
// file: /etc/docker/daemon.json
{
  "ipv6": true,
  "fixed-cidr-v6":"fd00:5723:8119:c016::/80",
  "experimental":true,
  "ip6tables":true
}
```


```sh
sudo docker run --rm -it \
  -p "22:22" \ 
  -e "PASSWORD=vyos-2022"\
  -v "/srv/ssh4to6proxy/keys/:/etc/ssh/keys/etc/ssh/" \
  ghcr.io/secshellnet/ssh4to6proxy
```

#### docker-compose
```yml
version: '3.9'

services:
  ssh4to6proxy:
    image: ghcr.io/secshellnet/ssh4to6proxy
    restart: always
    environment:
      - "PASSWORD=vyos-2022"
    volumes:
      - "/srv/share/keys/:/etc/ssh/keys/etc/ssh/"
    ports:
      - "22:22"
```

