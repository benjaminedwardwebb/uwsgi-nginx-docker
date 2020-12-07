FROM ubuntu:20.04
LABEL maintainer="Ben Webb <benjaminedwardwebb@gmail.com>"

# install dependencies
RUN apt-get update \
  && apt-get install -y supervisor \
  && apt-get install -y nginx \
  && apt-get install -y uwsgi-core uwsgi-plugin-python3 \
  && apt-get install -y python3

# environment variables
ENV APPUSER appuser
ENV SUPERVISORD_CONF /app/supervisord.conf
ENV NGINX_CONF /app/nginx.conf
ENV NGINX_USER www-data
ENV UWSGI_INI /app/uwsgi.ini

COPY ./setup.sh /setup.sh
RUN /setup.sh

# setup user
RUN useradd --create-home --shell /bin/bash $APPUSER
RUN gpasswd --add $NGINX_USER $APPUSER
RUN gpasswd --add $APPUSER $NGINX_USER

# switch from root to appuser 
#USER $APPUSER:$APPUSER

# expose ports
EXPOSE 80
EXPOSE 443

# By default, Nginx listens on port 80.
# To modify this, change LISTEN_PORT environment variable.
# (in a Dockerfile or with an option for `docker run`)
ENV LISTEN_PORT 80

# default app
COPY ./app /app

WORKDIR /
CMD ["/app/start.sh"]
