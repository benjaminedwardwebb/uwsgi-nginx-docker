#!/usr/bin/env sh
set -x

# supervisor setup
ln -s $SUPERVISORD_CONF /etc/supervisor/conf.d/supervisord.conf

# nginx setup
# TODO integrate nginx into supervisord maybe?
rm /etc/nginx/sites-enabled/default
ln -s $NGINX_CONF /etc/nginx/sites-enabled/site.conf
