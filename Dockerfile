FROM ubuntu:20.04

LABEL maintainer="Ben Webb <benjaminedwardwebb@gmail.com>"

# install dependencies
RUN apt-get update
RUN apt-get install -y supervisor
RUN apt-get install -y nginx
RUN apt-get install -y uwsgi-core uwsgi-plugin-python3
RUN apt-get install -y python3

# expose ports
EXPOSE 80
EXPOSE 443

# environment variables
ENV SUPERVISORD_CONF /app/supervisord.conf
ENV NGINX_CONF /app/nginx.conf
ENV UWSGI_INI /app/uwsgi.ini

# By default, Nginx listens on port 80.
# To modify this, change LISTEN_PORT environment variable.
# (in a Dockerfile or with an option for `docker run`)
ENV LISTEN_PORT 80

# default app
COPY ./app /app

WORKDIR /
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
