# docker-nginx-geoip2

This provides a simple nginx server answering with GeoIP2 country data in the headers and in a response JSON

Use it like this in your docker-compose.yml:
``` yaml
services:
  geoip:
    restart: always
    build:
      context: https://github.com/akretion/docker-nginx-geoip2.git#main
    ports:
      - 8050:80
    volumes:
      - 'geoipupdate_data:/usr/share/GeoIP:ro'
  geoipupdate:
    container_name: geoipupdate
    image: maxmindinc/geoipupdate
    restart: unless-stopped
    environment:
      - GEOIPUPDATE_ACCOUNT_ID=$GEOIPUPDATE_ACCOUNT_ID
      - GEOIPUPDATE_LICENSE_KEY=$GEOIPUPDATE_LICENSE_KEY
      - GEOIPUPDATE_EDITION_IDS=GeoLite2-Country
      - GEOIPUPDATE_FREQUENCY=72
    volumes:
      - 'geoipupdate_data:/usr/share/GeoIP'
volumes:
  geoipupdate_data:
    driver: local
version: '3.7'
```
