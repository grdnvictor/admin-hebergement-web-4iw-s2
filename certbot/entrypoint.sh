#!/bin/sh
set -e

echo "Starting certificate management at $(date)"

WEBROOT_PATH="/var/www/html"

certbot certonly --webroot -w $WEBROOT_PATH --non-interactive --agree-tos -m $EMAIL -d $DOMAINS
if [ $? -eq 0 ]; then
  echo "Certificate renewal successful!"
  $HOOK
else
  echo "Certificate renewal failed!"
  exit 1
fi

echo "0 */12 * * * $0" > /etc/crontabs/root
exec crond -f
