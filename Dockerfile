FROM nginx:stable

# Install module geoip2
RUN apt-get update
RUN apt-get install -y libnginx-mod-http-geoip2

# Update nginx config
ADD ./geoip2.conf /etc/nginx/conf.d/geoip2.conf

# Update server config
ADD ./default_server /etc/nginx/sites-enabled/default
