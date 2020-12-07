#!/usr/bin/env sh
set -x

# link default configs into place
ln -s $SUPERVISORD_CONF /etc/supervisor/conf.d/supervisord.conf

# TODO integrate nginx into supervisord maybe?
rm /etc/nginx/sites-enabled/default
ln -s $NGINX_CONF /etc/nginx/sites-enabled/site.conf
service nginx restart

exec "$@"
