# docker-nginx-geoip2

This provides a simple nginx server answering with GeoIP2 country data in the headers and in a response JSON

Use it like this in your docker-compose.yml:
``` yaml
services:
  geoip:
    restart: always
    build:
      context: https://github.com/akretion/docker-nginx-geoip2.git#main
      args:
        MAXMIND_ACCOUNT_ID: YOUR_ACCOUNT_ID
        MAXMIND_LICENSE_KEY: YOUR_LICENSE_KEY
    ports:
      - 8050:80
version: '3.7'
```
