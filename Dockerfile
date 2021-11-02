FROM ubuntu:20.04
ARG MAXMIND_ACCOUNT_ID
ARG MAXMIND_LICENSE_KEY

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:maxmind/ppa
# Install module geoip2 and geoipupdate
RUN apt-get update
RUN apt-get install -y nginx-light libnginx-mod-http-geoip2 geoipupdate cron

# Update nginx config
#RUN sed -i "/^pid/a include /etc/nginx/modules-enabled/50-mod-http-geoip2.conf;" /etc/nginx/nginx.conf
ADD ./geoip2.conf /etc/nginx/conf.d/geoip2.conf

# Update server config
ADD ./default_server /etc/nginx/sites-enabled/default

# Fetch GeoIp database
RUN sed -i "s/YOUR_ACCOUNT_ID_HERE/$MAXMIND_ACCOUNT_ID/g" /etc/GeoIP.conf
RUN sed -i "s/YOUR_LICENSE_KEY_HERE/$MAXMIND_LICENSE_KEY/g" /etc/GeoIP.conf
RUN geoipupdate
COPY /geoipupdate /etc/cron.d/geoipupdate

# Run nginx
EXPOSE 80/tcp
CMD nginx && tail -f /dev/null
