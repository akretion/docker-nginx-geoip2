FROM ubuntu:focal

ARG GEOIP2_PROXY
ARG GEOIP2_DEFAULT_CODE
ARG GEOIP2_DEFAULT_NAME
ARG GEOIP2_LANG

# Install module geoip2
RUN apt-get update
RUN apt-get install -y nginx libnginx-mod-http-geoip2

# Update nginx config
ADD ./geoip2.conf /etc/nginx/conf.d/geoip2.conf

RUN if test "$GEOIP2_PROXY" ; then sed -i "s|#geoip2_proxy.*|geoip2_proxy $GEOIP2_PROXY;|g" /etc/nginx/conf.d/geoip2.conf ; fi

RUN if test "$GEOIP2_DEFAULT_CODE" ; then sed -i "s|code\sdefault=\w\+\s|code default=$GEOIP2_DEFAULT_CODE |g" /etc/nginx/conf.d/geoip2.conf ; fi
RUN if test "$GEOIP2_DEFAULT_NAME" ; then sed -i "s|name\sdefault=\w\+\s|name default=$GEOIP2_DEFAULT_NAME |g" /etc/nginx/conf.d/geoip2.conf ; fi
RUN if test "$GEOIP2_LANG" ; then sed -i "s|country\snames\s\w\+;|country names $GEOIP2_LANG;|g" /etc/nginx/conf.d/geoip2.conf ; fi

# Update server config
ADD ./default_server /etc/nginx/sites-enabled/default

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
